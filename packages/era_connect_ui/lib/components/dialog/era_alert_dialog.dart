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
        child: Container(
          color: context.theme.backgroundColor,
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildContent(context),
              _buildActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      color: context.theme.backgroundColor,
      alignment: Alignment.centerLeft,
      child: Column(
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
            description!,
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
