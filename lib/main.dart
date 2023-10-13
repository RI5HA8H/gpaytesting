
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yuvasathi/homePage.dart';
import 'package:yuvasathi/previousHomePage.dart';
import 'package:yuvasathi/splashScreen.dart';
import 'package:yuvasathi/Utilles/searchableDropdown1.dart';
import 'ADMIN/adminHomePage.dart';
import 'ADMIN/adminLogin.dart';
import 'Resource/Colors/app_colors.dart';
import 'Resource/StringLocalization/languages.dart';



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = new MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yuva Sathi Application',
      locale: Locale('hi', 'IN'),
      translations: languages(),
      fallbackLocale: Locale('en', 'US'),

      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch:mainAppColor,
      ),
      home:  splashScreen(),
    );
  }
}
