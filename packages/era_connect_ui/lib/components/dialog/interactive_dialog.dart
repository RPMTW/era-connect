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

  /// Whether to adjust the left and right side ratio to 16:3 (default is 3:7).
  final bool isWide;

  /// The content of the dialog (right side).
  final Widget body;

  final Widget? statusBox;

  const InteractiveDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.logoBoxText,
      this.hasBrandText = false,
      this.isWide = false,
      required this.body,
      this.statusBox});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          const EdgeInsets.only(top: 85, bottom: 35, left: 85, right: 85),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 900,
        width: 1600,
        color: context.theme.backgroundColor,
        child: Row(
          children: [
            Expanded(flex: isWide ? 16 : 3, child: _buildLeftArea(context)),
            Expanded(flex: isWide ? 3 : 7, child: _buildRightArea(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftArea(BuildContext context) {
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

  Widget _buildRightArea(BuildContext context) {
    return Container(color: context.theme.deepBackgroundColor, child: body);
  }

  Widget _buildLogoBox(BuildContext context) {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
