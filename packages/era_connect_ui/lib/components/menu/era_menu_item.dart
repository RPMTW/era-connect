import 'package:era_connect_ui/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class EraMenuItem extends StatefulWidget {
  final EraMenuItemData data;
  final bool selected;
  final void Function() onTap;

  const EraMenuItem(
      {super.key,
      required this.data,
      required this.selected,
      required this.onTap});

  @override
  State<EraMenuItem> createState() => _EraMenuItemState();
}

class _EraMenuItemState extends State<EraMenuItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (widget.selected) return context.theme.surfaceColor;
      if (_isHovering) return context.theme.surfaceColor.withOpacity(0.5);

      return Colors.transparent;
    }

    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovering = false;
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 75,
            color: getColor(),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: Row(
              children: [
                SizedBox(
                    width: 33,
                    height: 33,
                    child: widget.selected
                        ? widget.data.selectedIcon
                        : widget.data.icon),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                          fontSize: _isHovering ? 17 : 19,
                          fontWeight: FontWeight.w700),
                      child: Text(
                        widget.data.title,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      switchInCurve: Curves.easeInOut,
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0, 0.5),
                                  end: const Offset(0, 0))
                              .animate(animation),
                          child: child,
                        );
                      },
                      child: Builder(
                          key: ValueKey(_isHovering),
                          builder: (context) {
                            if (_isHovering) {
                              return Text(
                                widget.data.subtitle,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context.theme.secondaryTextColor,
                                    fontWeight: FontWeight.w500),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EraMenuItemData {
  final Widget icon;
  final Widget selectedIcon;
  final String title;
  final String subtitle;

  const EraMenuItemData(
      {required this.icon,
      required this.selectedIcon,
      required this.title,
      required this.subtitle});
}
