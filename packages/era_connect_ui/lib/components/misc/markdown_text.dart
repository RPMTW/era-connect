import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MarkdownText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const MarkdownText(this.text, {super.key, this.style = const TextStyle()});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      selectable: false,
      styleSheet: MarkdownStyleSheet(
        p: style,
        a: style.copyWith(
          shadows: [
            Shadow(
                color: context.theme.accentColor, offset: const Offset(0, -2.5))
          ],
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          decorationColor: context.theme.accentColor,
          fontSize: style.fontSize != null ? style.fontSize! * 0.92 : null,
        ),
      ),
      onTapLink: (text, href, title) {
        if (href == null) return;
        launchUrlString(href);
      },
    );
  }
}
