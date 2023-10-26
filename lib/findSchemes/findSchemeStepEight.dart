

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import '../Schemes/schemList.dart';
import '../Utilles/allAPI.dart';
import '../Utilles/footer.dart';
import '../Utilles/helplineCardView.dart';
import '../Utilles/toasts.dart';
import '../Utilles/url.dart';
import '../homePage.dart';
import 'findSchemeStepSeaven.dart';

class findSchemeStepEight extends StatefulWidget {
  var ageValue;
  var genderValue;
  var skillValue;
  var districtValue;
  var residenceValue;
  var castValue;
  var empStatusValue;
  var eduStatusValue;

  findSchemeStepEight(this.ageValue,this.genderValue,this.skillValue,this.districtValue,this.residenceValue,this.castValue,this.empStatusValue,this.eduStatusValue);


  @override
  State<findSchemeStepEight> createState() => _findSchemeStepEightState(ageValue,genderValue,skillValue,districtValue,residenceValue,castValue,empStatusValue,eduStatusValue);
}

class _findSchemeStepEightState extends State<findSchemeStepEight> {
  _findSchemeStepEightState(ageValue,genderValue,skillValue,districtValue,residenceValue,castValue,empStatusValue,eduStatusValue);

  bool engLanguage = true;
  bool scroll = false;
  int userId = 0;
  var selectedValue ;
  var allcategoryList = [];
  var allcategoryDropdownList = [];
  var allcategoryDropdownvalue;


  @override
  void initState() {
    getSharedValue();
    getAllCategory();
    super.initState();
  }

  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId =prefs.getInt('userID')!;
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepSeaven()));
                        },
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20,20, 0),
                    child: Text('step8'.tr, style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding:EdgeInsets.fromLTRB(20, 0,20, 0),
                    child: Divider(color: Colors.black,),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 0),
                    child: Text('step8heading'.tr, style: TextStyle(fontSize: 16, color: Color(0xff7959AC),fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child:  Center(child: Image.asset('assets/images/rbb8.png',fit: BoxFit.fill,width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/2,)),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0,20, 30),
                    child: GroupButton(
                      isRadio: true,
                      onSelected: (val, i, selected) {
                        selectedValue=val;
                        print('ssssss--$selectedValue');
                      },
                      buttons: allcategoryDropdownList,
                      options: GroupButtonOptions(
                          runSpacing: 10,
                          buttonWidth:double.infinity,
                          buttonHeight: 50,
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
                          alignment: AlignmentDirectional.centerStart,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          unselectedBorderColor:  Color(0xffC5C5C5),
                          selectedBorderColor: Colors.green,
                          selectedTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                          textPadding: EdgeInsets.only(left: 16)
                      ),

                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 10),
                    child: ElevatedButton(
                      child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('submittext'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff7959AC)),
                      ),
                      onPressed: (){
                        if(selectedValue==null){
                          toasts().redToast('warningtoast'.tr);
                        }else{
                          for(int i=0;i<allcategoryList.length;i++){
                            if(allcategoryList[i]['service_title_eng']==selectedValue || allcategoryList[i]['service_title_hindi']==selectedValue){
                              var catid = allcategoryList[i]['id'];
                              var sponid = '';
                              var depid = '';
                              var ageid = '';
                              var ratid = '';
                              var castid = '';
                              var modeid = '';
                              var engTitle=allcategoryList[i]['service_title_eng'];
                              var hinTitle=allcategoryList[i]['service_title_hindi'];
                              var serviceURL=allcategoryList[i]['service_url'];
                              var serviceImg=allcategoryList[i]['service_image'];
                              var schemeCount=allcategoryList[i]['scheme_count'];

                              updateProfile(catid,sponid,depid,ageid,ratid,castid,modeid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount);
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => schemList(cid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount)));
                            }
                          }
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
              )
            ),
          )
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
          allcategoryList = getitems;
          getAllCategoryName(allcategoryList);
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

  void getAllCategoryName(var clist){
    print('cccccccccccccccccccc-----${clist}');
    for(int i=0;i<clist.length;i++){
      allcategoryDropdownList.insert(0,engLanguage ? clist[i]['service_title_eng'] : clist[i]['service_title_hindi']);
    }
    allcategoryDropdownList = allcategoryDropdownList.reversed.toList();
  }

  void updateProfile(var catid,var sponid,var depid,var ageid,var ratid,var castid,var modeid,var engTitle,var hinTitle,var serviceURL,var serviceImg,var schemeCount) async {
    setState(() {scroll=true;});
    var headers = {
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };

    print('aaaaaa1-------${widget.genderValue}');
    print('aaaaaa2-------${widget.skillValue}');
    print('aaaaaa3-------${widget.districtValue}');
    print('aaaaaa4-------${widget.residenceValue}');
    print('aaaaaa5-------${widget.castValue}');
    print('aaaaaa6-------${widget.empStatusValue}');
    print('aaaaaa7-------${widget.eduStatusValue}');
    print('aaaaaa8-------${catid}');


    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().updateProfileURL));
    request.fields.addAll({
      'youth_id': intToBase64(userId),
      'gender':'${widget.genderValue}',
      'district':'${widget.districtValue}',
      'location_type':'${widget.residenceValue}',
      'caste': '${widget.castValue}',
      'employment_status': '${widget.empStatusValue}',
      'last_qualification': '${widget.eduStatusValue}',
      'category':'$catid',
    });

    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if(response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => schemList(catid,sponid,depid,ageid,ratid,castid,modeid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount)), (Route<dynamic> route) => false);
      if(results['code']==200){
        //toasts().greenToast('Profile Update Successfully');
        setState(() {scroll = false;});

      }else{
        if(results['code']==319){
          //toasts().redToast('data already updated try again');
          setState(() {scroll = false;});
        }else{
          //toasts().redToast('Please Try Again');
          setState(() {scroll = false;});
        }
      }
    }
    else {
      toasts().redToast('Server Error');
      setState(() {scroll = false;});
    }
  }

  String intToBase64(int value) {
    final encoded = base64Encode(utf8.encode(value.toString()));
    return encoded;
  }

}
