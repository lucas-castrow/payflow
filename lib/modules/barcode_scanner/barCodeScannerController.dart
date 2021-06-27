import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode_scanner/barCodeScannerStatus.dart';

class BarCodeScannerController {
  final statusNotifier =
      ValueNotifier<BarCodeScannerStatus>(BarCodeScannerStatus());
  BarCodeScannerStatus get status => statusNotifier.value;
  set status(BarCodeScannerStatus status) => statusNotifier.value = status;

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  InputImage? imagePicker;
  CameraController? cameraController;
  void getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back);
      cameraController =
          CameraController(camera, ResolutionPreset.max, enableAudio: false);
      await cameraController!.initialize();

      scanWithCamera();
      listenCamera();
    } catch (e) {
      status = BarCodeScannerStatus.error(e.toString());
    }
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
        //print("TIPO : ${item.value.rawValue}");
        DateTime dateTimeCreatedAt = DateTime.parse('1997-10-07');
        DateTime dateTimeNow = DateTime.now();
        final differenceInDays =
            dateTimeNow.difference(dateTimeCreatedAt).inDays;
        final vencimentoInDays = barcode.toString().substring(5, 9);

        final differenceDays = int.parse(vencimentoInDays) - differenceInDays;

        final vencimento = dateTimeNow.add(Duration(days: differenceDays));
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarCodeScannerStatus.barcode(barcode);
        cameraController!.dispose();
        await barcodeScanner.close();
      }

      return;
    } catch (e) {
      print("ERRO DA LEITURA $e");
    }
  }

  void scanWithImagePicker() async {
    final response = await ImagePicker().getImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
  }

  void scanWithCamera() {
    status = BarCodeScannerStatus.available();
    Future.delayed(Duration(seconds: 20)).then((value) {
      if (status.hasBarcode == false)
        status = BarCodeScannerStatus.error("Timeout de leitura de boleto");
    });
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false)
      cameraController!.startImageStream((cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            final bytes = allBytes.done().buffer.asUint8List();
            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());
            final InputImageRotation imageRotation =
                InputImageRotation.Rotation_0deg;
            final InputImageFormat inputImageFormat =
                InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
                    InputImageFormat.NV21;
            final planeData = cameraImage.planes.map(
              (Plane plane) {
                return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width,
                );
              },
            ).toList();

            final inputImageData = InputImageData(
              size: imageSize,
              imageRotation: imageRotation,
              inputImageFormat: inputImageFormat,
              planeData: planeData,
            );
            final inputImageCamera = InputImage.fromBytes(
                bytes: bytes, inputImageData: inputImageData);

            scannerBarCode(inputImageCamera);
          } catch (e) {
            print(e);
          }
        }
      });
  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();
    if (status.showCamera) {
      cameraController!.dispose();
    }
  }
}
