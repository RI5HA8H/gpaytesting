


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Utilles/toasts.dart';
import 'package:yuvasathi/Utilles/url.dart';

import '../Schemes/schemList.dart';
import 'allAPI.dart';

class filter extends StatefulWidget {
   filter({Key? key,
    required this.catid,
    required this.engTitle,
     required this.hinTitle,
     required this.serviceURL,
     required this.serviceImg,
     required this.schemeCount
  }) : super(key: key);

  var catid;
   var engTitle;
   var hinTitle;
   var serviceURL;
   var serviceImg;
   var schemeCount;



  @override
  State<filter> createState() => _filterState(catid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount);
}

class _filterState extends State<filter> {
  _filterState(catid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount);
  late var data='';
  bool engLanguage = true;
  bool scroll = false;
  var allcastList = [];
  var castids;
  var ratingDV;
  var castDV;
  var appmodeDV;
  var ageDV;
  var ratingITM = ['1 Star'.tr, '2 Star'.tr, '3 Star'.tr, '4 Star'.tr, '5 Star'.tr,];
  //var casteITM = ["cast1".tr, "cast2".tr, "cast3".tr, "cast4".tr,"other".tr];
  var appmodeITM = ['online'.tr, 'offline'.tr, 'both'.tr,];
  var ageITM = [18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,38,40,41,42,43,44,45];

  @override
  void initState() {
    getSharedValue();
    getCaste();
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
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text('rating'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                isExpanded: true,
                iconStyleData: IconStyleData(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(Icons.keyboard_arrow_down),
                    )
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[50],
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),

                items: ratingITM.map((item11) {
                  return DropdownMenuItem(
                    value: item11.toString(),
                   child: Row(
                     children: [
                       for(int i=1;i<6;i++)
                         Icon(Icons.star,size: 16,color: i>ratingITM.indexOf(item11)+1 ? Colors.grey : Colors.orange,),
                     ],
                   ),
                   // child: Text(item.toString(),style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                  );
                }).toList(),
                onChanged: (newVal11) {
                  setState(() {
                    ratingDV = newVal11;
                  });
                },
                value: ratingDV,
              ),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            height: 30,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text('caste'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                isExpanded: true,
                iconStyleData: IconStyleData(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(Icons.keyboard_arrow_down),
                    )
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[50],
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),
                items: allcastList.map((item12) {
                  return DropdownMenuItem(
                    value: item12,
                    child: Text(engLanguage ? item12['caste_title_eng'] : item12['caste_title_hindi'].toString(),style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                  );
                }).toList(),
                onChanged: (newVal12) {
                  setState(() {
                    castDV = newVal12;
                    castids = castDV['id'];
                    print('castt-----$castids');
                  });
                },
                value: castDV,
              ),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            height: 30,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text('mode'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                isExpanded: true,
                iconStyleData: IconStyleData(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[50],
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),
                items: appmodeITM.map((item13) {
                  return DropdownMenuItem(
                    value: item13.toString(),
                    child: Text(item13.toString(),style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                  );
                }).toList(),
                onChanged: (newVal13) {
                    setState(() {
                      if(newVal13=='Online' || newVal13=='ऑनलाइन' ){
                        data = '1';
                      }else{
                        if(newVal13=='Offline' || newVal13=='ऑफलाइन'){
                          data = '2';
                        }else{
                          if(newVal13=='Both' || newVal13=='दोनों'){
                            data = '';
                          }else{
                            data = '';
                          }
                        }
                      }
                      appmodeDV=newVal13;
                      print('moddddd---$newVal13');
                    });
                },
                value: appmodeDV,
              ),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            height: 30,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text('age'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                isExpanded: true,
                iconStyleData: IconStyleData(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(Icons.keyboard_arrow_down),
                    )
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: MediaQuery.of(context).size.height/2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[50],
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),
                items: ageITM.map((item14) {
                  return DropdownMenuItem(
                    value: item14.toString(),
                    child: Text(item14.toString()+'  '+'year'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                  );
                }).toList(),
                onChanged: (newVal14) {
                  setState(() {
                    ageDV = newVal14;
                  });
                },
                value: ageDV,
              ),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            child: SizedBox(width: double.infinity,height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/ab_search.png', width: 22, height: 22, color: Colors.white,),
                    SizedBox(width: 10,),
                    Center(child: Text('search'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white))),
                  ],
                )),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green[400]),
            ),
            onPressed: (){
              if(ratingDV==null || castDV==null || appmodeDV==null || ageDV==null){
                toasts().redToast('warningtoast'.tr);
              }else{
                toasts().greenToast('rightsteptoast'.tr);
                var catid = widget.catid;
                var sponid = '';
                var depid = '';
                var ageid = ageDV;
                var ratid = ratingDV;
                var castid = castids;
                var modeid = data;
                print('ccccccid-----$castid');

                var engTitle=widget.engTitle;
                var hinTitle=widget.hinTitle;
                var serviceURL=widget.serviceURL;
                var serviceImg=widget.serviceImg;
                var schemeCount=widget.schemeCount;

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => schemList(catid,sponid,depid,ageid,ratid,castid,modeid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount)));
              }
            },
          ),
          SizedBox(height: 5,),
        ],
      ),
    );
  }
  Future<void> getCaste() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().casteURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      //print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          allcastList = getitems;
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
}
