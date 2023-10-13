
import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/animation/gf_animation.dart';
import 'package:getwidget/types/gf_animation_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Utilles/checkInternet.dart';
import 'package:yuvasathi/loginPage.dart';
import 'package:yuvasathi/previousHomePage.dart';
import 'homePage.dart';
import 'languageSelector.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  double _progressValue = 0.0;



  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    _animationController.addListener(() {
      setState(() {
        _progressValue = _animationController.value;
      });
    });
    Timer(Duration(seconds: 3),() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? engLanguage = prefs.getBool('engLanguage');
      int? userId =prefs.getInt('userID');
      print('hhhhhhhhhhh$engLanguage');
      print('hhhhhhhhhhh$userId');
      if(engLanguage.isNull){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>languageSelector()));
      }else
      {
        if(engLanguage==true){
          Get.updateLocale(Locale('en', 'US'));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>previousHomePage()));

        }else{
          Get.updateLocale(Locale('hi', 'IN'));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>previousHomePage()));
        }
      }
    });
    _animationController.repeat();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: screenHeight*0.75,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/icons/gov_up.png',),),
                Text('gov_up'.tr, style: TextStyle(fontSize: 10, color: Colors.black),),
                SizedBox(height: 10,),
                Container(height: 100,
                  width: 100,
                  child: Image.asset('assets/images/yogi.png',),),
                Text('welcom'.tr, style: TextStyle(fontSize: 16, color: Colors.black),),
                Container(
                  height: 120,
                  width: 300,
                  child: Image.asset('assets/icons/yuvalogo.png',),),
                Text('logobottom'.tr, style: TextStyle(fontSize: 16, color: Colors.black),),
                SizedBox(height: 30,),
                Container(width: MediaQuery.of(context).size.width / 2,
                  child: LinearProgressIndicator(
                    value: _progressValue,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),),
                SizedBox(height: 20,),
                Text('by'.tr, style: TextStyle(fontSize: 8, color: Colors.black),),

              ],
            ),
          ),
        ),
      bottomNavigationBar: Container(
        height: screenHeight*0.30,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashbottom.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/icons/sangh.png',),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('sanghtext'.tr, style: TextStyle(fontSize: 12,
                        color: Colors.black),),
                    Text('gov_up'.tr, style: TextStyle(fontSize: 10,
                        color: Colors.black),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}