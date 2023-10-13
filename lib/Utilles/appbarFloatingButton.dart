



import 'package:flutter/material.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/homePage.dart';
import 'package:yuvasathi/previousHomePage.dart';

class appbarFloatingButton extends StatefulWidget {
  const appbarFloatingButton({Key? key}) : super(key: key);

  @override
  State<appbarFloatingButton> createState() => _appbarFloatingButtonState();
}

class _appbarFloatingButtonState extends State<appbarFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/icons/navbarcircle.png',fit: BoxFit.cover,),
      ),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);
      },
    );
  }
}
