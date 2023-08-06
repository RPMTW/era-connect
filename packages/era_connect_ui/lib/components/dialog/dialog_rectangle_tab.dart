import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final String icon;
  final Widget? content;

  const TabItem({required this.title, required this.icon, this.content});
}

class DialogRectangleTab extends StatefulWidget {
  final String title;
  final List<TabItem> tabs;
  const DialogRectangleTab({super.key, required this.title, required this.tabs})
      : assert(tabs.length > 1);

  @override
  State<DialogRectangleTab> createState() => _DialogRectangleTabState();
}

class _DialogRectangleTabState extends State<DialogRectangleTab> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 16, color: context.theme.textColor),
        ),
        const SizedBox(height: 10),
        Wrap(
            spacing: 15,
            children: widget.tabs.map((e) => _buildTab(e)).toList()),
        const SizedBox(height: 30),
        _buildContent()
      ],
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: AnimatedSwitcher(
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, -0.1), end: Offset.zero)
                    .animate(animation),
                child: child,
              ),
            );
          },
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          duration: const Duration(milliseconds: 150),
          child: Container(
              key: ValueKey(_currentPage),
              child: widget.tabs[_currentPage].content)),
    );
  }

  Widget _buildTab(TabItem e) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      duration: const Duration(milliseconds: 150),
      child: _TabItemWidget(
        key: ValueKey(_currentPage),
        title: e.title,
        icon: e.icon,
        isSelected: widget.tabs.indexOf(e) == _currentPage,
        onTap: () async {
          int page = widget.tabs.indexOf(e);
          setState(() {
            _currentPage = page;
          });
        },
      ),
    );
  }
}

class _TabItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItemWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: context.theme.accentColor, width: 3)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EraIcon(name: icon, size: 50),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: context.theme.textColor),
            )
          ],
        ),
      ),
    );
  }
}
