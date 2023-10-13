

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import '../Controllers/homeSearchController.dart';
import '../SchemeDetails/schemeDetails1.dart';
import '../loginPage.dart';
import 'allAPI.dart';
import 'toasts.dart';
import 'url.dart';


class SearchableDropdown extends StatefulWidget {
  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  String? _selectedItem;
  //List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4','Item 1', 'Item 2', 'Item 3', 'Item 4'];

   final searchControllers controller = Get.find();

  List<String> citiesData=[];
  dynamic nullData=[];
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


  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      engLanguage = prefs.getBool('engLanguage')!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Obx(() => Visibility(
      visible: controller.activeIndex1.value == true,
      child: Container(
        color:  appcolors.primaryColor ,
        padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width*.7,
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  color: Colors.white,
                  child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'svn_subtile'.tr,
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      if(pattern==''){
                        return nullData;
                      }else{
                        return citiesData.where((item) => item.toLowerCase().contains(pattern.toLowerCase()));
                      }
                    },
                    itemBuilder: (context, suggestion) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(suggestion.toString(),style: TextStyle(fontSize: 10,color: Colors.black),),
                            IntrinsicHeight(child: Divider(thickness: 1,color: Colors.grey[200],),),
                          ],
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() async {
                        for(int i=0;i<schemeList.length;i++){
                          if(schemeList[i]['scheme_title_eng']==suggestion || schemeList[i]['scheme_title_hindi']==suggestion){
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

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            int? userId =prefs.getInt('userID');

                            if(userId==0 || userId==null){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                            }else{
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
                                  requirement_title_hindi
                              )));
                            }
                          }
                        }
                      });
                    },
                    noItemsFoundBuilder: (context) {
                      return ListTile(
                        title: Text('search1ifempty'.tr,style: TextStyle(fontSize: 8,color: Colors.red),),
                      );
                    },
                  ),
                ),
              ),
            ),
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
