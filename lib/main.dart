import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MyHomePage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCj2vL-pgI9PZjr-D1GVcjA4qzb2SdOFf4",
        projectId: "fir-f88a9",
        messagingSenderId: "763227955714",
        appId: "1:763227955714:web:ee513fe8dcb7555ceefd1b",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manthan',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
