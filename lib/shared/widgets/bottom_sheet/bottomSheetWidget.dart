import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/set_labels_buttons/setLabelButton.dart';

class BottomSheetWidget extends StatelessWidget {
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback primaryOnPressed;
  final VoidCallback secondaryOnPressed;
  final String title;
  final String subtitle;
  const BottomSheetWidget({
    Key? key,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.primaryOnPressed,
    required this.secondaryOnPressed,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Material(
          child: Container(
            color: AppColors.shape,
            child: Column(
              children: [
                Expanded(
                  child: Container(color: Colors.black.withOpacity(0.6)),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text.rich(
                        TextSpan(
                            style: TextStyles.buttonBoldHeading,
                            text: title,
                            children: [
                              TextSpan(
                                  text: "\n$subtitle",
                                  style: TextStyles.buttonHeading),
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(height: 1, color: AppColors.stroke),
                    SetLabelButton(
                      enablePrimaryColor: true,
                      primaryLabel: primaryLabel,
                      secondaryLabel: secondaryLabel,
                      primaryOnPressed: primaryOnPressed,
                      secondaryOnPressed: secondaryOnPressed,
                      firstFlex: 1,
                      secondFlex: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
