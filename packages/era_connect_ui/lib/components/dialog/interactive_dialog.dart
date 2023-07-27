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
  final Widget child;

  const InteractiveDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.logoBoxText,
      required this.child,
      this.hasBrandText = true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 85, vertical: 45),
      child: Container(
        height: 900,
        width: 1600,
        decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(flex: 3, child: _buildLeftArea(context)),
            Expanded(flex: 7, child: _buildRightArea(context)),
          ],
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
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 15,
              children: [
                _buildLogoBox(context),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 60,
                      color: context.theme.textColor,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 17,
                      color: context.theme.tertiaryTextColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Placeholder(),
          ],
        ));
  }

  Container _buildRightArea(BuildContext context) {
    return Container(
      color: context.theme.deepBackgroundColor,
      child: child,
    );
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
                    fontWeight: FontWeight.w500,
                    color: context.theme.accentColor)),
          ),
        ],
      ),
    );
  }
}
