import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';

import 'package:payflow/shared/widgets/boleto_list/boletoListController.dart';
import 'package:payflow/shared/widgets/boleto_list/boletoListWidget.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Row(
              children: [
                Text(
                  "Meus extratos",
                  style: TextStyles.titleBoldHeading,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Divider(
              color: AppColors.stroke,
              thickness: 1,
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoListWidget(
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
