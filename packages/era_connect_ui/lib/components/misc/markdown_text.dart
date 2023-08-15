import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MarkdownText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const MarkdownText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      selectable: false,
      styleSheet: MarkdownStyleSheet(p: style),
      onTapLink: (text, href, title) {
        if (href == null) return;
        launchUrlString(href);
      },
    );
  }
}
