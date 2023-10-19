


import 'dart:async';
import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/appbarFloatingButton.dart';
import 'package:yuvasathi/findSchemes/findSchemeStepTwo.dart';
import 'package:yuvasathi/homePage.dart';
import 'package:yuvasathi/photoGallery.dart';
import 'package:yuvasathi/pressRelease.dart';

import 'Utilles/bottomNavigation.dart';
import 'Utilles/checkInternet.dart';
import 'Utilles/complexModuleView.dart';
import 'Utilles/moduleview.dart';
import 'Utilles/primaryActions.dart';
import 'aboutPRD.dart';
import 'aboutYuvaSathi.dart';
import 'faq.dart';
import 'findSchemes/findSchemeStepOne.dart';
import 'forum.dart';

class previousHomePage extends StatefulWidget {
  const previousHomePage({Key? key}) : super(key: key);

  @override
  State<previousHomePage> createState() => _previousHomePageState();
}

class _previousHomePageState extends State<previousHomePage> {


  StreamSubscription? internetconnection;
  bool isoffline = false;
  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
          print(T);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        setState(() {
          isoffline = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => checkInternet()));
        });
      });
    }
  }

  void initState() {
    super.initState();
    CheckUserConnection();
    _checkVersion();
    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => checkInternet()));
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
      super.initState();
    });
  }

  @override
  void dispose() {
    internetconnection!.cancel();
    super.dispose();
  }

  void _checkVersion() async {

    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: appcolors.primaryColor,
        iconTheme: IconThemeData(color:appcolors.whiteColor),
        title: Image.asset('assets/icons/yuvasathi_purewhite.png',width: 120,height: 40,fit:BoxFit.fill),
        actions: [primaryActions()],
      ),
      body: Container(
        color: appcolors.primaryColor,
        padding: EdgeInsets.only(top: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),),
          child: SingleChildScrollView(
            child: Container(
              height: 700,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: GridView(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 150,
                  ),
                  children:[
                    InkWell(
                      child: complexModuleView(title: 'appbarItem1'.tr, path: 'assets/icons/abicon1.png',),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => aboutYuvaSathi()));
                      },
                    ),
                    InkWell(
                      child: complexModuleView(title: 'appbarItem2'.tr, path: 'assets/icons/abicon2.png',),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => homePage()));
                      },
                    ),
                    InkWell(
                      child: complexModuleView(title: 'appbarItem3'.tr, path: 'assets/icons/abicon3.png',),
                      onTap: () async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        int? userId =prefs.getInt('userID');
                        if(userId==0 || userId==null){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepOne()));
                        }else{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepTwo()));
                        }
                      },
                    ),
                    InkWell(
                      child: complexModuleView(title: 'appbarItem4'.tr, path: 'assets/icons/abicon4.png',),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => aboutPRD()));
                      },
                    ),
                    InkWell(
                      child: complexModuleView(title: 'appbarItem5'.tr, path: 'assets/icons/abicon5.png',),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => faq()));
                      },
                    ),
                    InkWell(
                      child: complexModuleView(title: 'appbarItem6'.tr, path: 'assets/icons/abicon6.png',),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => forum()));
                      },
                    ),
                    InkWell(
                      child: complexModuleView(title: 'appbarItem7'.tr, path: 'assets/icons/abicon7.png',),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PressRelease()));
                      },
                    ),
                    InkWell(
                      child: complexModuleView(title:'appbarItem8'.tr, path: 'assets/icons/abicon8.png',),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => photoGallery()));
                      },
                    ),


                  ],
                ),
              ),
              ),
          ),
          ),
        ),
      bottomNavigationBar: bottomNavigation(),
      floatingActionButton: appbarFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
