import 'package:era_connect_ui/components/misc/lib.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter/material.dart';

class InteractiveDialog extends StatelessWidget {
  final String title;
  final String description;

  /// The text next to the logo box.
  final String logoBoxText;

  /// Whether to show the brand text (Era Connect) in the logo box.
  final bool hasBrandText;

  /// The content of the dialog (right side).
  final Widget body;

  final Widget? statusBox;

  const InteractiveDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.logoBoxText,
      this.hasBrandText = true,
      required this.body,
      this.statusBox});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          const EdgeInsets.only(top: 75, bottom: 35, left: 85, right: 85),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 900,
          width: 1600,
          color: context.theme.backgroundColor,
          child: Row(
            children: [
              Expanded(flex: 3, child: _buildLeftArea(context)),
              Expanded(flex: 7, child: _buildRightArea(context)),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLeftArea(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: _buildLogoBox(context)),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 60,
                      color: context.theme.textColor,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 17, color: context.theme.tertiaryTextColor),
                ),
              ],
            ),
            if (statusBox != null) statusBox!,
          ],
        ));
  }

  Container _buildRightArea(BuildContext context) {
    return Container(color: context.theme.deepBackgroundColor, child: body);
  }

  Container _buildLogoBox(BuildContext context) {
    return Container(
      width: hasBrandText ? 220 : 102,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 2,
              color: context.theme.secondarySurfaceColor,
              strokeAlign: BorderSide.strokeAlignOutside),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: context.theme.secondarySurfaceColor,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  const EraLogo(size: 20),
                  if (hasBrandText) ...const [
                    SizedBox(width: 10),
                    EraBrandText(fontSize: 25, height: 0)
                  ]
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(logoBoxText,
                style: TextStyle(
                    fontFamily: 'Geo',
                    fontSize: 25,
                    color: context.theme.accentColor)),
          ),
        ],
      ),
    );
  }
}
