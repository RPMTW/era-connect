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
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            color: context.theme.backgroundColor,
            constraints: const BoxConstraints(
              minHeight: 350,
              maxHeight: 450,
              minWidth: 580,
              maxWidth: 620,
            ),
            child: Column(
              children: [
                Expanded(flex: 4, child: _buildContent(context)),
                Expanded(flex: 1, child: _buildActions(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 35, right: 35),
      color: context.theme.backgroundColor,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: content == null ? 45 : 40,
                color: context.theme.textColor,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 15),
          MarkdownText(
            description,
            style:
                TextStyle(fontSize: 16, color: context.theme.tertiaryTextColor),
          ),
          const SizedBox(height: 20),
          if (content != null) content!,
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: context.theme.deepBackgroundColor,
      alignment: Alignment.centerRight,
      child: Wrap(spacing: 10, children: actions),
    );
  }
}
