import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/home/homePage.dart';
import 'package:payflow/modules/insert_boleto/insertBoletoPage.dart';
import 'package:payflow/modules/splash/splashPage.dart';
import 'package:payflow/shared/models/userModel.dart';
import 'modules/barcode_scanner/barCodeScannerPage.dart';
import 'modules/login/loginPage.dart';
import 'shared/themes/appcolors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayFlow',
      theme: ThemeData(
          primarySwatch: Colors.orange, primaryColor: AppColors.primary),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashPage(),
        "/home": (context) => HomePage(
              user: ModalRoute.of(context)!.settings.arguments as UserModel,
            ),
        "/login": (context) => LoginPage(),
        "/barcode_scanner": (context) => BarCodeScannerPage(),
        "/insert_boleto": (context) => InsertBoletoPage(
              barcode: ModalRoute.of(context) != null
                  ? ModalRoute.of(context)!.settings.arguments.toString()
                  : null,
            )
      },
    );
  }
}
