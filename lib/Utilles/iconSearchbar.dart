import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Utilles/toasts.dart';
import 'package:yuvasathi/Utilles/url.dart';
import '../Schemes/schemList.dart';
import 'allAPI.dart';

class iconSearchbar extends StatefulWidget {
  const iconSearchbar({Key? key}) : super(key: key);

  @override
  State<iconSearchbar> createState() => _iconSearchbarState();
}

class _iconSearchbarState extends State<iconSearchbar> {
  bool engLanguage = true;
  bool scroll = false;
  var allcategoryDropdownList = [];
  var allcategoryDropdownvalue;
  List<Map<String, dynamic>> list = [];

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
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8)),
      child: Container(
        width: double.infinity,
        height: 50,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text('iconSearchtextHeading'.tr, style: TextStyle(fontSize: 12, color: Color(0xff707070)),),
            isExpanded: true,
            dropdownStyleData: DropdownStyleData(
              elevation: 1,
              maxHeight: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
            ),
            iconStyleData: IconStyleData(
                icon: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xff707070),
                size: 18,
              ),
            )),
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            selectedItemBuilder: (BuildContext context) {
              return allcategoryDropdownList.map<Widget>((item) {
                return Row(
                  children: [
                    Center(
                        child: Text(
                      'iconSearchtextHeading'.tr,
                      style: TextStyle(fontSize: 12, color: Color(0xff707070)),
                    )),
                  ],
                );
              }).toList();
            },
            items: allcategoryDropdownList.map((iconitem) {
              return DropdownMenuItem(
                value: iconitem,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(urls().base_url + iconitem['service_image'].toString(), width: 30, height: 30,),
                        SizedBox(width: 10,),
                        Text(engLanguage ? iconitem['service_title_eng'] : iconitem['service_title_hindi'], style: TextStyle(fontSize: 12, color: Color(0xff707070)),),
                      ],
                    ),
                    Divider(color: Colors.grey[200], thickness: 1,),
                  ],
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                allcategoryDropdownvalue  = newValue;
                var catid=allcategoryDropdownvalue['id'];
                var sponid = '';
                var depid = '';
                var ageid = '';
                var ratid = '';
                var castid = '';
                var modeid = '';
                var engTitle=allcategoryDropdownvalue['service_title_eng'];
                var hinTitle=allcategoryDropdownvalue['service_title_hindi'];
                var serviceURL=allcategoryDropdownvalue['service_url'];
                var serviceImg=allcategoryDropdownvalue['service_image'];
                var schemeCount=allcategoryDropdownvalue['scheme_count'];
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => schemList(catid,sponid,depid,ageid,ratid,castid,modeid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount)));
              });
            },
            value: allcategoryDropdownvalue,
          ),
        ),
      ),
    );
  }

  Future<void> getAllCategory() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().allCategoryURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          allcategoryDropdownList = getitems;
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
