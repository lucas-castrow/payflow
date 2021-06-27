import 'package:camera/camera.dart';

class BarCodeScannerStatus {
  final bool isAvailable;
  final String error;
  final String barcode;
  final bool stopScanner;

  BarCodeScannerStatus({
    this.isAvailable = false,
    this.error = "",
    this.barcode = "",
    this.stopScanner = false,
  });

  factory BarCodeScannerStatus.available() => BarCodeScannerStatus(
        isAvailable: true,
        stopScanner: false,
      );

  factory BarCodeScannerStatus.error(String message) => BarCodeScannerStatus(
        error: message,
        stopScanner: true,
      );

  factory BarCodeScannerStatus.barcode(String barcode) => BarCodeScannerStatus(
        barcode: barcode,
        stopScanner: true,
      );

  bool get showCamera => isAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarcode => barcode.isNotEmpty;
}
