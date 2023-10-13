


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_text_search/dropdown_text_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Controllers/homeSearchController.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/toasts.dart';
import 'package:yuvasathi/Utilles/url.dart';

import '../SchemeDetails/schemeDetails1.dart';
import 'allAPI.dart';

class searchbar1 extends StatefulWidget {
  const searchbar1({Key? key}) : super(key: key);

  @override
  State<searchbar1> createState() => _searchbar1State();
}

class _searchbar1State extends State<searchbar1> {

  final searchControllers controller = Get.find();

  TextEditingController searchController = TextEditingController();
  FocusNode searchNode=FocusNode();

  List<String> citiesData=[];
  dynamic nullData=[];
  double listHeight = 200;
  bool engLanguage=true;
  bool scroll = false;
  var schemeList = [];
  bool listVisibility=false;
  int listItemCount=0;

  @override
  void initState() {
    getSharedValue();
    getAllCategory();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      engLanguage = prefs.getBool('engLanguage')!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
      visible: controller.activeIndex1.value == true,
      child: Container(
        color:  appcolors.primaryColor ,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20) ,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      width: MediaQuery.of(context).size.width*.7,
                      height: 50,
                      color: Colors.white,
                      child:TextField(
                        focusNode: searchNode,
                        controller:searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'svn_subtile'.tr,
                            hintStyle: TextStyle(fontSize: 12)
                        ),
                        onChanged: (String? val){
                          print('kkkkkkkk----$val');
                          setState(() {
                            if(val.toString().isEmpty){
                              listVisibility=false;
                            }else{
                              listVisibility=true;
                              listItemCount=0;
                            }

                          });
                        },
                      ),
                    )),

                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)
                  ),
                  child: Container(
                    width:MediaQuery.of(context).size.width*.15,
                    height: 50,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset('assets/icons/ab_search.png', width: 16, height: 16, color: Colors.white,),
                    ),
                  ),
                )
              ],
            ),
            listVisibility ? Container(
              height: 260,
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: citiesData.length,
                      itemBuilder: (context, index){
                        late String position=citiesData[index].toString();
                        if(position.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Container(
                            child: InkWell(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(citiesData[index],style: TextStyle(fontSize: 8,color: Colors.black),),
                                  IntrinsicHeight(child: Divider(thickness: 1,color: Colors.grey[200],),),
                                ],
                              ),
                              onTap: (){
                                for(int i=0;i<schemeList.length;i++){
                                  if(schemeList[i]['scheme_title_eng']==citiesData[index] || schemeList[i]['scheme_title_hindi']==citiesData[index]){
                                    var scheme_id =  schemeList[i]['id'];
                                    var scheme_title_eng =  schemeList[i]['scheme_title_eng'];
                                    var scheme_title_hindi=  schemeList[i]['scheme_title_hindi'];
                                    var service_title_eng =  schemeList[i]['service_title_eng'];
                                    var service_title_hindi=  schemeList[i]['service_title_hindi'];
                                    var departments_title_eng = schemeList[i]['departments_title_eng'];
                                    var departments_title_hindi=  schemeList[i]['departments_title_hindi'];
                                    var scheme_logo =  urls().base_url+schemeList[i]['service_image'];
                                    var ratting=  schemeList[i]['ratting'];
                                    var sponsor_by=  schemeList[i]['sponsor_by'];
                                    var residence_by=  schemeList[i]['residence_by'];
                                    var mode=  schemeList[i]['mode'];
                                    var employee_status=  schemeList[i]['employee_status'];
                                    var hashtags =  schemeList[i]['hashtags'];
                                    var sources_url=  schemeList[i]['sources_url'];
                                    var overview_eng =  convertHtmlToPlainText(schemeList[i]['overview_eng']);
                                    var overview_hindi=  convertHtmlToPlainText(schemeList[i]['overview_hindi']);
                                    var benefits_eng =  convertHtmlToPlainText(schemeList[i]['benefits_eng']);
                                    var benefits_hindi=  convertHtmlToPlainText(schemeList[i]['benefits_hindi']);
                                    var eligibility_eng =  convertHtmlToPlainText(schemeList[i]['eligibility_eng']);
                                    var eligibility_hindi=  convertHtmlToPlainText(schemeList[i]['eligibility_hindi']);
                                    var requirement_title_eng =  convertHtmlToPlainText(schemeList[i]['requirement_title_eng']);
                                    var requirement_title_hindi =  convertHtmlToPlainText(schemeList[i]['requirement_title_hindi']);

                                    searchNode.unfocus();
                                    searchController.clear();
                                    listVisibility=false;

                                    setState(() {});


                                    Navigator.push(context, MaterialPageRoute(builder: (context) => schemeDetails1(
                                      scheme_id,
                                      scheme_title_eng,
                                      scheme_title_hindi,
                                      service_title_eng,
                                      service_title_hindi,
                                      departments_title_eng,
                                      departments_title_hindi,
                                      scheme_logo,
                                      ratting,
                                      sponsor_by,
                                      residence_by,
                                      mode,
                                      employee_status,
                                      hashtags,
                                      sources_url,
                                      overview_eng,
                                      overview_hindi,
                                      benefits_eng,
                                      benefits_hindi,
                                      eligibility_eng,
                                      eligibility_hindi,
                                      requirement_title_eng,
                                        requirement_title_hindi,
                                    )));
                                  }
                                }
                              },
                            ),
                          );
                        }else{
                          Container(height: 0,);
                        }

                      },

                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      child: SizedBox(width: double.infinity,height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.highlight_remove,color: Colors.white,),
                              SizedBox(width: 10,),
                              Center(child: Text('remove'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white))),
                            ],
                          )),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green[400]),),
                      onPressed: (){
                        searchNode.unfocus();
                        searchController.clear();
                        listVisibility=false;
                        listItemCount=0;
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ) : Container(height: 0,)
          ],
        ),
      ),
    ));
  }

  Future<void> getAllCategory() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().schemeURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      //print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data']['data'];
        setState(() {

          schemeList = getitems;
          //print('ssssssss--$schemeList');

          for(int i=0;i<schemeList.length;i++){
            citiesData.insert(i,schemeList[i]['scheme_title_eng']);
          }
           // print('dddddd--$citiesData');

          scroll = false;
        });
        //something
      } else {
        toasts().redToast('Please Try Again');
        setState(() {
          scroll = false;
        });
      }
    } else {
      toasts().redToast('Server Error');
      setState(() {
        scroll = false;
      });
    }
  }

  String convertHtmlToPlainText(String htmlText) {
    final String plainText = htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
    return plainText;
  }
}
