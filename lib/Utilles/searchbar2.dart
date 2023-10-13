
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Utilles/toasts.dart';
import 'package:yuvasathi/Utilles/url.dart';
import '../Controllers/homeSearchController.dart';
import '../Schemes/schemList.dart';
import 'allAPI.dart';

class searchbar2 extends StatefulWidget {
  const searchbar2({Key? key}) : super(key: key);

  @override
  State<searchbar2> createState() => _searchbar2State();
}

class _searchbar2State extends State<searchbar2> {

  final searchControllers controller = Get.find();


  bool engLanguage = true;
  bool scroll1 = false;
  bool scroll2 = false;
  bool scroll3 = false;
    var schemedropdownvalue;
    var govrnmentdropdownvalue;
    var departmentdropdownvalue;
    var schemeitems =[];
    var govrnmentitems=[] ;
    var departmentitems =[];
    var sid;
    var gid;
    var did;
    var catid;
    var engTitle;
    var hinTitle;
    var serviceURL;
    var serviceImg;
    var schemeCount;

    @override
    void initState() {
      getSharedValue();
      getAllScheme();
      getAllGov();
      getAllDep();
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
    return Obx(() => Visibility(
      visible: controller.activeIndex2.value == true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text('searchtextsubhead1'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
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
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),

                items: schemeitems.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(engLanguage ? item['service_title_eng'] : item['service_title_hindi'],style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    print('ssss---$newVal');
                    schemedropdownvalue = newVal;
                    sid=schemedropdownvalue['id'];
                    catid = sid;
                    engTitle=schemedropdownvalue['service_title_eng'];
                    hinTitle=schemedropdownvalue['service_title_hindi'];
                    serviceURL=schemedropdownvalue['service_url'];
                    serviceImg=schemedropdownvalue['service_image'];
                    schemeCount=schemedropdownvalue['scheme_count'];
                  });
                },
                value: schemedropdownvalue,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            height: 45,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text('searchtextsubhead2'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
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
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),
                items: govrnmentitems.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(engLanguage ? item['sponsor_english'] : item['sponsor_hindi'],style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    print('gggg---$newVal');
                    govrnmentdropdownvalue = newVal;
                    gid=govrnmentdropdownvalue['id'].toString();

                  });
                },
                value: govrnmentdropdownvalue,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            height: 45,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text('searchtextsubhead3'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
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
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),
                items: departmentitems.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(engLanguage ? item['departments_title_eng'] : item['departments_title_hindi'],style: TextStyle(fontSize: 10,color: Color(0xff707070)),),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    print('dddd---$newVal');
                    departmentdropdownvalue = newVal;
                    did=departmentdropdownvalue['id'];

                  });
                },
                value: departmentdropdownvalue,
              ),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            child: SizedBox(width: double.infinity,height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/ab_search.png', width: 22, height: 22, color: Colors.white,),
                    SizedBox(width: 10,),
                    Center(child: Text('searchscheme'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white))),
                  ],
                )),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green[400]),
            ),
            onPressed: (){
              if(schemedropdownvalue==null || govrnmentdropdownvalue==null || departmentdropdownvalue==null){
                toasts().redToast('warningtoast'.tr);
              }else{
                toasts().greenToast('rightsteptoast'.tr);
                setState(() {
                  var sponid = sid;
                  var depid = did;
                  var ageid = '';
                  var ratid = '';
                  var castid = '';
                  var modeid = '';
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => schemList(catid,sponid,depid,ageid,ratid,castid,modeid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount)));
                });
              }
            },
          ),
          SizedBox(height: 5,),
        ],
      ),
    ));
  }


    Future<void> getAllScheme() async {
      setState(() {scroll1 = true;});
      var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().allCategoryURL));

      var response = await request.send();

      var results = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        print(await 'aaaaaaaaa-----${results}');
        if (results['code'] == 200) {
          var getitems = results['data'];
          setState(() {
            schemeitems = getitems;
            scroll1 = false;
          });
          //something
        } else {
          toasts().redToast('Please Try Again');
          setState(() {
            scroll1 = false;
          });
        }
      } else {
        toasts().redToast('Server Error');
        setState(() {
          scroll1 = false;
        });
      }
    }

    Future<void> getAllGov() async {
      setState(() {scroll2 = true;});
      var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().sponsorURL));

      var response = await request.send();

      var results = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        print(await 'aaaaaaaaa-----${results}');
        if (results['code'] == 200) {
          var getitems = results['data'];
          setState(() {
            govrnmentitems = getitems;
            scroll2 = false;
          });
          //something
        } else {
          toasts().redToast('Please Try Again');
          setState(() {
            scroll2 = false;
          });
        }
      } else {
        toasts().redToast('Server Error');
        setState(() {
          scroll2 = false;
        });
      }
    }

    Future<void> getAllDep() async {
      setState(() {scroll3 = true;});
      var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().departmentURL));

      var response = await request.send();

      var results = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        print(await 'aaaaaaaaa-----${results}');
        if (results['code'] == 200) {
          var getitems = results['data'];
          setState(() {
            departmentitems = getitems;
            scroll3 = false;
          });
          //something
        } else {
          toasts().redToast('Please Try Again');
          setState(() {
            scroll3 = false;
          });
        }
      } else {
        toasts().redToast('Server Error');
        setState(() {
          scroll3 = false;
        });
      }
    }
}
