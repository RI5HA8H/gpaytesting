

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuvasathi/ADMIN/adminHomePage.dart';
import 'package:yuvasathi/ADMIN/adminLogin.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/primaryActions.dart';

import 'Utilles/action.dart';
import 'Utilles/iconSearchbar.dart';
import 'Utilles/slider.dart';

class aboutYuvaSathi extends StatefulWidget {
  const aboutYuvaSathi({Key? key}) : super(key: key);

  @override
  State<aboutYuvaSathi> createState() => _aboutYuvaSathiState();
}

class _aboutYuvaSathiState extends State<aboutYuvaSathi> {
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
      body: SingleChildScrollView(
        child: Container(
          color: appcolors.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //iconSearchbar(),
                    //SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset('assets/icons/abicon1.png',width: 30,height: 30,),
                        SizedBox(width: 10,),
                        Text('appbarItem1'.tr,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    IntrinsicHeight(child: Divider(color: Colors.grey,thickness: 1,)),
                    SizedBox(height: 10,),
                    slider(),
                    SizedBox(height: 10,),
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
                            Text('aboutsubappbarh1'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),textAlign:TextAlign.left,),
                            SizedBox(height: 10,),
                            Text('aboutsubappbarh2'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),textAlign:TextAlign.left,),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      StylishCardWidget(title: 'mision'.tr,iconpath: 'assets/icons/Mission.png', content: 'aboutmision'.tr),
                      SizedBox(height: 20,),
                      StylishCardWidget(title: 'vision'.tr,iconpath: 'assets/icons/Vision.png', content: 'aboutvision'.tr),
                      SizedBox(height: 20,),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[100],
                          ),
                          child: Center(child: Text('adminLogin'.tr,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),)),
                        ),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminLogin()));
                        },
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class StylishCardWidget extends StatelessWidget {
  final String title;
  final String iconpath;
  final String content;

  const StylishCardWidget({required this.title,required this.iconpath, required this.content});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15,left: 15,right: 15),
              child: Row(
                children: [
                  Image.asset(iconpath,width: 20,height: 20,),
                  SizedBox(width: 10,),
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black))
                ],
              ),
            ),
            Divider(color: Colors.grey[200],thickness: 1,),
            SizedBox(height: 5,),
            Container(padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),width:MediaQuery.of(context).size.width*0.95,child: Text(content, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Colors.black),textAlign:TextAlign.left,)),
          ],
        ),
      ),
    );

  }}