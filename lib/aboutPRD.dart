


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/primaryActions.dart';

import 'Utilles/action.dart';
import 'Utilles/iconSearchbar.dart';

class aboutPRD extends StatefulWidget {
  const aboutPRD({Key? key}) : super(key: key);

  @override
  State<aboutPRD> createState() => _aboutPRDState();
}

class _aboutPRDState extends State<aboutPRD> {

  bool engLanguage = true;
  int userId = 0;

  @override
  void initState() {
    getSharedValue();
    super.initState();
  }

  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      engLanguage = prefs.getBool('engLanguage')!;
      userId =prefs.getInt('userID')!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20.0,
        shadowColor: Colors.transparent,
        backgroundColor: appcolors.primaryColor,
        iconTheme: IconThemeData(color:appcolors.whiteColor),
        title: Image.asset('assets/icons/yuvalogo.png',width: 150,height: 50,fit:BoxFit.fill,color: Colors.white,),
        actions: [primaryActions(),],
      ),
      body:SingleChildScrollView(
        child: Container(
          color: appcolors.primaryColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //iconSearchbar(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset('assets/icons/abicon4.png',width: 30,height: 30,),
                        SizedBox(width: 16,),
                        Text('appbarItem4'.tr,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    IntrinsicHeight(child: Divider(color: Colors.grey[500],thickness: 1,)),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: Image.asset('assets/icons/sangh.png',),),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('sanghtexts'.tr, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold, color: Colors.white),),
                            Text('gov_up'.tr, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold,color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                    IntrinsicHeight(child: Divider(color: Colors.grey[500],thickness: 1,)),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('whosubappbarh1'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.left,),
                            SizedBox(height: 10,),
                            Text('whosubappbarh2'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.left,),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      StylishWhoTextWidget(title: 'whosteps1'.tr,),
                      SizedBox(height: 20,),
                      StylishWhoTextWidget(title: 'whosteps2'.tr,),
                      SizedBox(height: 20,),
                      StylishWhoTextWidget(title: 'whosteps3'.tr,),
                      SizedBox(height: 20,),
                      StylishWhoTextWidget(title: 'whosteps4'.tr,),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class StylishWhoTextWidget extends StatelessWidget {
  final String title;
  const StylishWhoTextWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(width: MediaQuery.of(context).size.width*0.9,child: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.left,)),
        ),
      ),
    );
  }
}