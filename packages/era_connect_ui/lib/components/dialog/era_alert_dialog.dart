import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class EraAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final Widget? content;
  final List<Widget> actions;

  const EraAlertDialog(
      {super.key,
      required this.title,
      required this.description,
      this.content,
      this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.only(top: 280, bottom: 230),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        color: context.theme.backgroundColor,
        child: Column(
          children: [
            Expanded(flex: 3, child: _buildContent(context)),
            Expanded(flex: 1, child: _buildActions(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      color: context.theme.backgroundColor,
      constraints: const BoxConstraints.expand(width: 600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 40,
                color: context.theme.textColor,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style:
                TextStyle(fontSize: 17, color: context.theme.tertiaryTextColor),
          ),
          const SizedBox(height: 20),
          content ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: context.theme.deepBackgroundColor,
      constraints: const BoxConstraints.expand(width: 600),
      child: Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.end,
        spacing: 10,
        children: actions,
      ),
    );
  }
}
