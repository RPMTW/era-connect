import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';

class EraAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final Widget? content;
  final List<Widget> actions;
  final bool loadingIndicator;

  const EraAlertDialog(
      {super.key,
      required this.title,
      required this.description,
      this.content,
      this.actions = const [],
      this.loadingIndicator = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: 600, minWidth: 400, minHeight: 250),
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(context),
                if (loadingIndicator) const LinearProgressIndicator(),
                Flexible(child: _buildContent(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, loadingIndicator ? 10 : 15),
      alignment: Alignment.centerLeft,
      color: context.theme.backgroundColor,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 28,
            color: context.theme.textColor,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      color: context.theme.deepBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              MarkdownText(
                description,
                style: TextStyle(
                    fontSize: 16, color: context.theme.secondaryTextColor),
              ),
              if (content != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: content!,
                ),
            ],
          ),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(spacing: 10, children: actions),
    );
  }
}
