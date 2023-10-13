
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import '../Utilles/allAPI.dart';
import '../Utilles/footer.dart';
import '../Utilles/helplineCardView.dart';
import '../Utilles/toasts.dart';
import '../Utilles/url.dart';
import '../homePage.dart';
import 'findSchemeStepFive.dart';
import 'findSchemeStepSeaven.dart';
import 'findSchemeStepThree.dart';

class findSchemeStepFour extends StatefulWidget {
  var ageValue;
  var genderValue;
  var skillValue;

  findSchemeStepFour(this.ageValue,this.genderValue,this.skillValue);

  @override
  State<findSchemeStepFour> createState() => _findSchemeStepFourState(ageValue,genderValue,skillValue);
}

class _findSchemeStepFourState extends State<findSchemeStepFour> {
  _findSchemeStepFourState(ageValue,genderValue,skillValue);

  bool engLanguage = true;
  bool scroll = false;
  var selectedValue ;
  var allresidenseList = [];
  var allresidenseNameDropdownList = [];
  var allresidenseDropdownvalue;

  var allDistrictDropdownList = [];
  var districtDropdownvalue;


  @override
  void initState() {
    getSharedValue();
    getPlaceType();
    getDistrict();
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 10,
        title: IntrinsicHeight(
          child: Row(
            children: [
              Image.asset('assets/icons/yuvalogo.png',width: 120,height: 50,fit:BoxFit.fill),
              VerticalDivider(color: Colors.grey,thickness: 1),
              Image.asset('assets/icons/dept_name_hindi.png',width: 120,height: 40,fit:BoxFit.fill),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:appcolors.blackColor),
      ),
      body: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: Text('appbarSecondTitle'.tr,style: TextStyle(fontSize: 9,color: Colors.white),textAlign: TextAlign.center,maxLines: 3,)),
            backgroundColor: Color(0xff7959AC),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.purple[50],
              child: scroll ? Container(height:MediaQuery.of(context).size.height*0.8,child: Center(child: CircularProgressIndicator(),)) :  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 /* Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: InkWell(
                        child: Container(
                          width: 100,
                          height: 30,
                          color: Colors.grey[300],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back),
                              SizedBox(width: 5,),
                              Text('backButton'.tr),
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepThree()));
                        },
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20,20, 0),
                    child: Text('step4'.tr, style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding:EdgeInsets.fromLTRB(20, 0,20, 0),
                    child: Divider(color: Colors.black,),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 0),
                    child: Text('step4heading'.tr, style: TextStyle(fontSize: 18, color: Color(0xff7959AC),fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20,10,20, 10),
                    child: Text('step4subheading'.tr, style: TextStyle(fontSize: 12, color: Colors.grey),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child:  Center(child: Image.asset('assets/images/rbb4.png',fit: BoxFit.fill,width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/2,)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text('selectdistrict'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
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
                            color: Colors.white,
                          ),
                        ),
                        buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                        ),
                        items: allDistrictDropdownList.map((item) {
                          return DropdownMenuItem(
                            value: item['id'],
                            child: Text(engLanguage ? item['district_title_eng'].toString() :  item['district_title_hindi'].toString(),style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            districtDropdownvalue = newVal;
                          });
                        },
                        value: districtDropdownvalue,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 10),
                    child: Text('placeType'.tr, style: TextStyle(fontSize: 18, color: Color(0xff7959AC),fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 10),
                    child: GroupButton(
                      isRadio: true,
                      onSelected: (val, i, selected) {
                        allresidenseDropdownvalue=i+1;
                      },
                      buttons: allresidenseNameDropdownList,
                      options: GroupButtonOptions(
                          buttonWidth:80,
                          buttonHeight: 40,
                          runSpacing: 10,
                          unselectedColor: Colors.white,
                          selectedColor: Colors.green,
                          /*unselectedShadow: [
                            BoxShadow(
                              color: Color(0xffC5C5C5).withOpacity(0.5), // Shadow color
                              spreadRadius: 2,                     // Spread radius
                              blurRadius: 5,                       // Blur radius
                              offset: Offset(0, 3),                // Offset in the Y direction
                            ),
                          ],*/
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          unselectedBorderColor:  Color(0xffC5C5C5),
                          selectedBorderColor: Colors.green,
                          selectedTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                          unselectedTextStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30,20, 10),
                    child: ElevatedButton(
                      child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('next'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff7959AC)),
                      ),
                      onPressed: (){
                        if(districtDropdownvalue==null||allresidenseDropdownvalue==null){
                          toasts().redToast('warningtoast'.tr);
                        }else{
                          toasts().greenToast('rightsteptoast'.tr);
                          setState(() {
                            // scroll=true;
                          });
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepFive(widget.ageValue,widget.genderValue,widget.skillValue,districtDropdownvalue,allresidenseDropdownvalue)));
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: helplineCardView(),
                  ),
                  footer(),
                ],
              ),
            ),
          )
      ),
    );
  }

  Future<void> getPlaceType() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().residenceURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          allresidenseList = getitems;
          getPlaceTypeName(allresidenseList);
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

  void getPlaceTypeName(var clist){
    print('cccccccccccccccccccc-----${clist}');
    for(int i=0;i<clist.length;i++){
      allresidenseNameDropdownList.insert(0,engLanguage ? clist[i]['residence_english'] : clist[i]['residence_hindi']);
    }
    allresidenseNameDropdownList = allresidenseNameDropdownList.reversed.toList();
  }

  Future<void> getDistrict() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().districtURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          allDistrictDropdownList = getitems;
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
