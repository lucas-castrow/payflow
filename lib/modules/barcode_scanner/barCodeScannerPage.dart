import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barCodeScannerController.dart';
import 'package:payflow/modules/barcode_scanner/barCodeScannerStatus.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottomSheetWidget.dart';
import 'package:payflow/shared/widgets/set_labels_buttons/setLabelButton.dart';

class BarCodeScannerPage extends StatefulWidget {
  const BarCodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarCodeScannerPageState createState() => _BarCodeScannerPageState();
}

class _BarCodeScannerPageState extends State<BarCodeScannerPage> {
  final controller = BarCodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert_boleto",
            arguments: controller.status.barcode);
      }
      print("BARCODE: ${controller.status.barcode}");
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(children: [
        ValueListenableBuilder<BarCodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  color: Colors.blue,
                  child: controller.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            }),
        RotatedBox(
          quarterTurns: 1,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  "Escaneie o c??digo de barras do boleto",
                  style: TextStyles.buttonBackground,
                ),
                leading: BackButton(
                  color: AppColors.background,
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              bottomNavigationBar: SetLabelButton(
                primaryLabel: 'Inserir c??digo do boleto',
                primaryOnPressed: () {
                  Navigator.pushReplacementNamed(context, "/insert_boleto");
                },
                secondaryLabel: 'Adicionar da galeria',
                secondaryOnPressed: () {},
              )),
        ),
        ValueListenableBuilder<BarCodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return Align(
                    alignment: Alignment.bottomLeft,
                    child: BottomSheetWidget(
                      primaryLabel: "Escanear Novamente",
                      secondaryLabel: "Digitar c??digo",
                      primaryOnPressed: () {
                        controller.scanWithCamera();
                      },
                      secondaryOnPressed: () {
                        Navigator.pushReplacementNamed(
                            context, "/insert_boleto");
                      },
                      title: "N??o foi possivel identificar um c??digo de barras",
                      subtitle:
                          "Tente escanear novamente ou digite o c??digo do seu boleto",
                    ));
              } else {
                return Container();
              }
            }),
      ]),
    );
  }
}
