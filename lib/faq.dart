


import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:custom_accordion/custom_accordion.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';

import 'Models/faqListModels.dart';
import 'Utilles/action.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/iconSearchbar.dart';
import 'Utilles/primaryActions.dart';
import 'Utilles/url.dart';

class faq extends StatefulWidget {
  const faq({Key? key}) : super(key: key);

  @override
  State<faq> createState() => _faqState();
}

class _faqState extends State<faq> {
  bool engLanguage = true;
  late Future<List<dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    getSharedValue();
    futureData = fetchData();
  }

  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      engLanguage = prefs.getBool('engLanguage')!;
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
      body: SingleChildScrollView(
        child: Container(
          color: appcolors.primaryColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    iconSearchbar(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset('assets/icons/abicon5.png',width: 30,height: 30,),
                        SizedBox(width: 16,),
                        Text('appbarItem5'.tr,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
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
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                  color: Colors.grey[200],
                  child: FutureBuilder<List<dynamic>>(
                    future: futureData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: MediaQuery.of(context).size.height*0.7,
                          child: Center(child: CircularProgressIndicator(
                            color: appcolors.primaryColor,)),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          height: MediaQuery.of(context).size.height*0.7,
                          child: Center(child: CircularProgressIndicator(
                            color: appcolors.primaryColor,)),
                        );
                      } else {
                        final data = snapshot.data!;
                        print('ddddddddddd---------$data');
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                          final item = data[index];
                          return   CustomAccordion(
                            title: engLanguage ? item['faq_question_eng'] : item['faq_question_hindi'],
                            headerBackgroundColor: Colors.white,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            subTitleStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            toggleIconOpen: Icons.keyboard_arrow_down_sharp,
                            toggleIconClose: Icons.keyboard_arrow_up_sharp,
                            headerIconColor: Colors.black,
                            accordionElevation: 0,
                            showContent: false,
                            widgetItems: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(engLanguage ? item['faq_question_eng'] : item['faq_question_hindi'],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.left,),
                                  SizedBox(height: 10,),
                                  Text(engLanguage ? item['faq_answer_eng'] : item['faq_answer_hindi'],style: TextStyle(fontSize: 12,color: Colors.black),textAlign: TextAlign.left,),
                                ],
                              ),
                            ),
                          );
                    },
                  );
             }}),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
        Uri.parse(urls().base_url + allAPI().faqURL));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}