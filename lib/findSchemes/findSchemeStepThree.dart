
import 'dart:convert';

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
import 'package:http/http.dart' as http;
import 'findSchemeStepFour.dart';
import 'findSchemeStepSeaven.dart';
import 'findSchemeStepTwo.dart';


class findSchemeStepThree extends StatefulWidget {
  var ageValue;
  var genderValue;

  findSchemeStepThree(this.ageValue,this.genderValue);

  @override
  State<findSchemeStepThree> createState() => _findSchemeStepThreeState(ageValue,genderValue);
}

class _findSchemeStepThreeState extends State<findSchemeStepThree> {
  _findSchemeStepThreeState(ageValue,genderValue);

  bool engLanguage = true;
  bool scroll = false;
  var skilldropdownvalue;
  var skillitems = [];

  @override
  void initState() {
    getSharedValue();
    getSkills();
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
        title: Image.asset(engLanguage ? 'assets/images/stepsearch-appbar-english-logo.png' : 'assets/images/stepsearch-appbar-logo-hindi.png',fit:BoxFit.fill),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:appcolors.blackColor),
      ),
      body: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Container(padding: EdgeInsets.only(left: 5,right: 5),child: Center(child: Text('appbarSecondTitle'.tr,style: TextStyle(fontSize: 9,color: Colors.white),textAlign: TextAlign.center,maxLines: 3,))),
            backgroundColor: Color(0xff7959AC),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.purple[50],
              child: scroll ? Container(height:MediaQuery.of(context).size.height*0.8,child: Center(child: CircularProgressIndicator(),)) : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Padding(
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepTwo()));
                        },
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20,20, 0),
                    child: Text('step3'.tr, style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding:EdgeInsets.fromLTRB(20, 0,20, 0),
                    child: Divider(color: Colors.black,),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 0),
                    child: Text('step3heading'.tr, style: TextStyle(fontSize: 18, color: Color(0xff7959AC),fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20,10,20, 10),
                    child: Text('step3subheading'.tr, style: TextStyle(fontSize: 12, color: Colors.grey),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child:  Center(child: Image.asset('assets/images/rbb3.png',fit: BoxFit.fill,width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/2,)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text('selectSkill'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
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
                        items: skillitems.map((item) {
                          return DropdownMenuItem(
                            value: item['id'],
                            child: Text(engLanguage ? item['skill_title_eng'].toString() :  item['skill_title_hindi'].toString(),style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            skilldropdownvalue = newVal;
                          });
                        },
                        value: skilldropdownvalue,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 10),
                    child: ElevatedButton(
                      child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('next'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff7959AC)),
                      ),
                      onPressed: (){
                        if(skilldropdownvalue==null){
                          toasts().redToast('warningtoast'.tr);
                        }else{
                          toasts().greenToast('rightsteptoast'.tr);
                          setState(() {
                            // scroll=true;
                          });
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepFour(widget.ageValue,widget.genderValue,skilldropdownvalue)));
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

  Future<void> getSkills() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().skillURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          skillitems = getitems;
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
