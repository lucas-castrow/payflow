import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/divider_vertical/dividerVertical.dart';
import 'package:payflow/shared/widgets/label_button/labelButton.dart';

class SetLabelButton extends StatelessWidget {
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback primaryOnPressed;
  final VoidCallback secondaryOnPressed;
  final int firstFlex;
  final int secondFlex;
  final bool enablePrimaryColor;
  final bool enableSecondaryColor;
  const SetLabelButton(
      {Key? key,
      required this.primaryLabel,
      required this.secondaryLabel,
      required this.primaryOnPressed,
      required this.secondaryOnPressed,
      this.firstFlex = 4,
      this.secondFlex = 1,
      this.enablePrimaryColor = false,
      this.enableSecondaryColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 57,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
          ),
          Container(
            height: 56,
            child: Row(children: [
              Expanded(
                  flex: firstFlex,
                  child: LabelButton(
                    label: primaryLabel,
                    onPressed: primaryOnPressed,
                    style: enablePrimaryColor ? TextStyles.buttonPrimary : null,
                  )),
              DividerVertical(),
              Expanded(
                  flex: secondFlex,
                  child: LabelButton(
                      label: secondaryLabel,
                      onPressed: secondaryOnPressed,
                      style: enableSecondaryColor
                          ? TextStyles.buttonPrimary
                          : null)),
            ]),
          ),
        ],
      ),
    );
  }
}
