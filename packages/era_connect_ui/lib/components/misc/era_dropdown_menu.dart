import 'package:era_connect_ui/components/buttons/era_basic_button.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'era_icon.dart';

class EraDropdownMenu extends StatefulWidget {
  final List<EraDropdownMenuItem> items;
  final int initialIndex;

  const EraDropdownMenu({super.key, required this.items, this.initialIndex = 0})
      : assert(items.length > 0);

  @override
  State<EraDropdownMenu> createState() => _EraDropdownMenuState();
}

class _EraDropdownMenuState extends State<EraDropdownMenu>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late final AnimationController _animationController;

  int _selectedIndex = 0;
  FocusScopeNode? _focusScopeNode;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.items[_selectedIndex];

    return CompositedTransformTarget(
      link: _layerLink,
      child: _buildItem(
        item: item,
        isOverlay: false,
        onTap: _showOverlay,
      ),
    );
  }

  @override
  void dispose() {
    _layerLink.leader?.dispose();
    _overlayEntry?.dispose();
    _focusScopeNode?.dispose();
    super.dispose();
  }

  void _showOverlay() {
    final renderBox = context.findRenderObject();
    if (renderBox is! RenderBox) return;

    _focusScopeNode = FocusScopeNode();
    _overlayEntry =
        OverlayEntry(builder: (context) => _buildOverlay(renderBox.size.width));

    Overlay.of(context).insert(_overlayEntry!);
    FocusScope.of(context).setFirstFocus(_focusScopeNode!);
    _animationController.forward();
  }

  Future<void> _removeOverlay() async {
    await _animationController.reverse();
    _overlayEntry?.remove();
    _focusScopeNode?.dispose();
    _overlayEntry = null;
    _focusScopeNode = null;
  }

  Widget _buildItem(
      {required EraDropdownMenuItem item,
      required bool isOverlay,
      required VoidCallback onTap}) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: IconTheme(
        data: const IconThemeData(size: 25),
        child: Row(
          children: [
            item.icon,
            const SizedBox(width: 15),
            DefaultTextStyle(
                style: TextStyle(
                    fontSize: 16, fontFamily: context.theme.fontFamily),
                child: item.label),
            if (!isOverlay) ...[
              const Spacer(),
              EraIcon.material(
                Icons.drag_handle,
                color: context.theme.tertiaryTextColor,
              )
            ],
          ],
        ),
      ),
    );

    return EraBasicButton(
      onPressed: () {
        onTap.call();
      },
      style: EraBasicButtonStyle(
          backgroundColor: isOverlay
              ? Colors.transparent
              : context.theme.deepBackgroundColor,
          hoverColor: Colors.transparent,
          borderRadius: 15),
      child: child,
    );
  }

  Widget _buildOverlay(double width) {
    final int initialIndex;

    if (widget.initialIndex >= 1) {
      initialIndex = widget.initialIndex - 1;
    } else {
      initialIndex = widget.initialIndex;
    }

    final items = PageStorage(
      bucket: PageStorageBucket(),
      child: FocusScope(
        node: _focusScopeNode,
        onKey: (node, event) {
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            _removeOverlay();
          }

          return KeyEventResult.ignored;
        },
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.surfaceColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: MaterialStatePropertyAll(context.theme.accentColor),
              crossAxisMargin: 10,
              mainAxisMargin: 10,
            ),
            child: ScrollablePositionedList.builder(
              padding: const EdgeInsets.only(right: 20),
              itemCount: widget.items.length,
              initialScrollIndex: initialIndex,
              itemBuilder: (content, index) {
                final item = widget.items[index];

                return _buildItem(
                  item: item,
                  isOverlay: true,
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    _removeOverlay();
                    item.onTap?.call();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _removeOverlay,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _animationController.value,
            child: child,
          );
        },
        child: Stack(
          children: [
            Container(color: context.theme.primaryColor.withOpacity(0.3)),
            Positioned(
              height: 200,
              width: width + 50,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0, -80),
                child: items,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EraDropdownMenuItem {
  final EraIcon icon;
  final Widget label;
  final VoidCallback? onTap;

  const EraDropdownMenuItem(
      {required this.icon, required this.label, this.onTap});
}
