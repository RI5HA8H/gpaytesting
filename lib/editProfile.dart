
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/userProfile.dart';
import 'package:http/http.dart' as http;
import 'Utilles/allAPI.dart';
import 'Utilles/editText.dart';
import 'Utilles/profileEditText.dart';
import 'Utilles/toasts.dart';
import 'Utilles/url.dart';

class editProfile extends StatefulWidget {

  var userName ;
  var userPhone ;
  var userEmail ;
  var dob ;
  var gender ;
  var caste ;
  var service ;
  var empstatus ;
  var lastqualification ;
  var state ;
  var district ;
  var typrofarea ;

  editProfile(this.userName, this.userPhone,this.userEmail, this.dob, this.gender,this.caste,this.service, this.empstatus,this.lastqualification, this.state,this.district, this.typrofarea,);


  @override
  State<editProfile> createState() => _editProfileState(userName,userPhone,userEmail,dob,gender,caste,service,empstatus,lastqualification,state,district,typrofarea,);
}

class _editProfileState extends State<editProfile> {
  _editProfileState(userName,userPhone,userEmail,dob,gender,caste,service,empstatus,lastqualification,state,district,typrofarea,);

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNoFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  String studobController = "";
  late String genderId;

  var genderitems = ['male'.tr,'female'.tr, 'other'.tr,];

  bool scroll1 = false;
  bool scroll2 = false;
  bool scroll3 = false;
  bool scroll4 = false;
  bool scroll5 = false;
  bool scroll6 = false;
  bool scroll7 = false;

  var casteitems = [];
  var serviceitems = [];
  var statusitems = [];
  var qualificationitems = [];
  var stateitems = [];
  var districtitems = [];
  var typeofareaitems = [];

  var gendersdropdownvalue;
  var castedropdownvalue;
  var servicedropdownvalue;
  var statusdropdownvalue;
  var qualificationdropdownvalue;
  var statedropdownvalue;
  var districtdropdownvalue;
  var areadropdownvalue;
  bool engLanguage = true;
  int userId = 0;




  DateTime selectedDate =  DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1947,1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print('dddddddd$selectedDate');
      });
    }
  }


  @override
  void initState() {
    nameController = TextEditingController(text:  widget.userName);
    phoneController = TextEditingController(text: widget.userPhone);
    emailController = TextEditingController(text: widget.userEmail);
    genderId= widget.gender;

    castedropdownvalue= widget.caste;
    areadropdownvalue= widget.typrofarea;
    statedropdownvalue=  widget.state;
    districtdropdownvalue=  widget.district;
    servicedropdownvalue=  widget.service;
    statusdropdownvalue= widget.empstatus;
    qualificationdropdownvalue= widget.lastqualification;

    getCaste();
    getAllCategory();
    getEmpStatus();
    getEducation();
    getState();
    getDistrict();
    getPlaceType();
    getLanguage();

    print('ggggg5----$districtdropdownvalue');
    print('ggggg6----$areadropdownvalue');
    print('ggggg7----$castedropdownvalue');
    print('ggggg8----$statusdropdownvalue');
    print('ggggg9----$qualificationdropdownvalue');
    print('ggggg10---$servicedropdownvalue');
    print('gggg11----$statedropdownvalue');
    super.initState();
  }

  Future getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    engLanguage = prefs.getBool('engLanguage')!;
    userId =prefs.getInt('userID')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("editprofile".tr,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      content: Container(
        height: MediaQuery.of(context).size.height/2,
        child: scroll1 || scroll2 || scroll3 || scroll4 || scroll5 || scroll6 || scroll7 ? Center(child: CircularProgressIndicator(strokeWidth: 3,)) : SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              profileEditText(
                controllers: nameController,
                focusNode: nameFocusNode,
                hint: 'username'.tr,
                keyboardTypes: TextInputType.name,
                maxlength: 30,
              ),
              profileEditText(
                controllers: emailController,
                focusNode: emailFocusNode,
                hint: 'useremail'.tr,
                keyboardTypes: TextInputType.emailAddress,
                maxlength: 50,
              ),

              TextField(
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon:GestureDetector(child: Icon(Icons.calendar_month),
                    ),
                    //labelText: "DOB - ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                    hintText: 'DOB : ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                    hintStyle: TextStyle(fontSize: 12)
                ),
                onTap: (){
                  _selectDate(context);
                  studobController="${selectedDate.toLocal()}".split(' ')[0];
                  print('ttttttttt$studobController');
                },
              ),

              DropdownButtonFormField(
                hint: Text("gender".tr,style: TextStyle(fontSize: 12),),
                items: genderitems.map((item1) {
                  return DropdownMenuItem(
                    value: item1.toString(),
                    child: Text(item1.toString(),style: TextStyle(fontSize: 12),),
                  );
                }).toList(),
                onChanged: (newVal1) {
                  setState(() {
                    print('gggg=------$newVal1');
                    //gendersdropdownvalue = 'M';
                  });
                },
                value: gendersdropdownvalue,
              ),

              DropdownButtonFormField(
                hint: Text(castedropdownvalue!=null ? getCastName(int.parse('$castedropdownvalue')) : "caste".tr,style: TextStyle(fontSize: 12),),
                items: casteitems.map((item2) {
                  return DropdownMenuItem(
                    value: item2['id'],
                    child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item2['caste_title_eng'] : item2['caste_title_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  );
                }).toList(),
                onChanged: (newVal2) {
                  setState(() {
                    castedropdownvalue = newVal2;
                    print('caassstttttttttttttt----$castedropdownvalue');
                  });
                },
                value: castedropdownvalue,
              ),

              DropdownButtonFormField(
                hint: Text(servicedropdownvalue!=null ? getServiceName(int.parse('$servicedropdownvalue')) : "service".tr,style: TextStyle(fontSize: 12),),
                items: serviceitems.map((item3) {
                  return DropdownMenuItem(
                    value: item3['id'],
                    child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item3['service_title_eng'] : item3['service_title_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  );
                }).toList(),
                onChanged: (newVal3) {
                  setState(() {
                    servicedropdownvalue = newVal3;
                  });
                },
                value: servicedropdownvalue,
              ),

              DropdownButtonFormField(
                hint: Text(statusdropdownvalue!=null ? getStatusName(int.parse('$statusdropdownvalue')) : "empstatus".tr,style: TextStyle(fontSize: 12),),
                items: statusitems.map((item4) {
                  return DropdownMenuItem(
                    value: item4['id'],
                    child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item4['status_english'] : item4['status_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  );
                }).toList(),
                onChanged: (newVal4) {
                  setState(() {
                    statusdropdownvalue = newVal4;
                  });
                },
                value: statusdropdownvalue,
              ),

             /* DropdownButtonFormField(
                hint: Text(qualificationdropdownvalue!=null ? getQualificationName(int.parse('$qualificationdropdownvalue')) : "lastqualification".tr,style: TextStyle(fontSize: 12),),
                items: qualificationitems.map((item5) {
                  return DropdownMenuItem(
                    value: item5['id'],
                    child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item5['education_title_eng'] : item5['education_title_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  );
                }).toList(),
                onChanged: (newVal5) {
                  setState(() {
                    qualificationdropdownvalue = newVal5;
                  });
                },
                value: qualificationdropdownvalue,
              ),*/

              DropdownButtonFormField(
                hint: Text(statedropdownvalue!=null  ? getStateName(int.parse('$statedropdownvalue')) : "state".tr,style: TextStyle(fontSize: 12),),
                items: stateitems.map((item6) {
                  return DropdownMenuItem(
                    value: item6['id'],
                    child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item6['state_eng_name'] : item6['state_hindi_name'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  );
                }).toList(),
                onChanged: (newVal6) {
                  setState(() {
                    statedropdownvalue = newVal6;
                  });
                },
                value: statedropdownvalue,
              ),

             /* DropdownButtonFormField(
                hint: Text(districtdropdownvalue!=null ? getDistrictName(int.parse('$districtdropdownvalue')) : "district".tr,style: TextStyle(fontSize: 12),),
                items: districtitems.map((item7) {
                  return DropdownMenuItem(
                    value: item7['id'],
                    child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item7['district_title_eng'] : item7['district_title_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  );
                }).toList(),
                onChanged: (newVal7) {
                  setState(() {
                    districtdropdownvalue = newVal7;
                  });
                },
                value: districtdropdownvalue,
              ),*/

              DropdownButtonFormField(
                hint: Text(areadropdownvalue!=null ? getTypeOfAreaName(int.parse('$areadropdownvalue')): "typrofarea".tr,style: TextStyle(fontSize: 12),),
                items: typeofareaitems.map((item8) {
                  return DropdownMenuItem(
                    value: item8['id'],
                    child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item8['residence_english'] : item8['residence_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  );
                }).toList(),
                onChanged: (newVal8) {
                  setState(() {
                    areadropdownvalue = newVal8;
                  });
                },
                value: areadropdownvalue,
              ),

            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("cancel".tr),
        ),
        TextButton(
          onPressed: () {
            updateProfile();
          },
          child: Text("updateProfile".tr),
        ),
      ],
    );
  }

  Future<void> getCaste() async {
    setState(() {scroll1 = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().casteURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          casteitems = getitems;
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

  Future<void> getAllCategory() async {
    setState(() {scroll2 = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().allCategoryURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          serviceitems = getitems;
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

  Future<void> getEmpStatus() async {
    setState(() {scroll3 = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().employeestatusURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          statusitems = getitems;
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

  Future<void> getEducation() async {
    setState(() {scroll4 = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().educationURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          qualificationdropdownvalue = getitems;
          scroll4 = false;
        });
        //something
      } else {
        toasts().redToast('Please Try Again');
        setState(() {
          scroll4 = false;
        });
      }
    } else {
      toasts().redToast('Server Error');
      setState(() {
        scroll4 = false;
      });
    }
  }

  Future<void> getState() async {
    setState(() {scroll5 = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().stateURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          stateitems = getitems;
          scroll5 = false;
        });
        //something
      } else {
        toasts().redToast('Please Try Again');
        setState(() {
          scroll5 = false;
        });
      }
    } else {
      toasts().redToast('Server Error');
      setState(() {
        scroll5 = false;
      });
    }
  }

  Future<void> getDistrict() async {
    setState(() {scroll6 = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().districtURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          districtitems = getitems;
          scroll6 = false;
        });
        //something
      } else {
        toasts().redToast('Please Try Again');
        setState(() {
          scroll6 = false;
        });
      }
    } else {
      toasts().redToast('Server Error');
      setState(() {
        scroll6 = false;
      });
    }
  }

  Future<void> getPlaceType() async {
    setState(() {scroll7 = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().residenceURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          typeofareaitems = getitems;
          scroll7 = false;
        });
        //something
      } else {
        toasts().redToast('Please Try Again');
        setState(() {
          scroll7 = false;
        });
      }
    } else {
      toasts().redToast('Server Error');
      setState(() {
        scroll7 = false;
      });
    }
  }

  String getGenderName(int id){
    String title='';
    if(genderitems[0]==id){
      gendersdropdownvalue='M';
      title=genderitems[0];
    }
    if(genderitems[1]==id){
      gendersdropdownvalue='F';
      title=genderitems[1];
    }
    if(genderitems[2]==id){
      gendersdropdownvalue='T';
      title=genderitems[2];
    }

    return title;
  }

  String getCastName(int id){
    String title='';
    for(int i=0;i<casteitems.length;i++){
      if(casteitems[i]['id']==id){
        castedropdownvalue=id;
        title=engLanguage ? casteitems[i]['caste_title_eng'] : casteitems[i]['caste_title_hindi'];
      }
    }
    return title;
  }

  String getServiceName(int id){
    String title='';
    for(int i=0;i<serviceitems.length;i++){
      if(serviceitems[i]['id']==id){
        servicedropdownvalue=id;
        title=engLanguage ? serviceitems[i]['service_title_eng'] : serviceitems[i]['service_title_hindi'];
      }
    }
    return title;
  }

  String getStatusName(int id){
    String title='';
    for(int i=0;i<statusitems.length;i++){
      if(statusitems[i]['id']==id){
        statusdropdownvalue=id;
        title=engLanguage ? statusitems[i]['status_english'] : statusitems[i]['status_hindi'];
      }
    }
    return title;
  }

  String getQualificationName(int id){
    String title='';
    for(int i=0;i<qualificationitems.length;i++){
      if(qualificationitems[i]['id']==id){
        qualificationdropdownvalue=id;
        title=engLanguage ? qualificationitems[i]['education_title_eng'] : qualificationitems[i]['education_title_hindi'];
      }
    }
    return title;
  }

  String getStateName(int id){
    String title='';
    for(int i=0;i<stateitems.length;i++){
      if(stateitems[i]['id']==id){
        statedropdownvalue=id;
        title=engLanguage ? stateitems[i]['state_eng_name'] : stateitems[i]['state_hindi_name'];
      }
    }
    return title;
  }

  String getDistrictName(int id){
    String title='';
    for(int i=0;i<districtitems.length;i++){
      if(districtitems[i]['id']==id){
        districtdropdownvalue=id;
        title=engLanguage ? districtitems[i]['district_title_eng'] : districtitems[i]['district_title_hindi'];
      }
    }
    return title;
  }

  String getTypeOfAreaName(int id){
    String title='';
    for(int i=0;i<typeofareaitems.length;i++){
      if(typeofareaitems[i]['id']==id){
        areadropdownvalue=id;
        title=engLanguage ? typeofareaitems[i]['residence_english'] : typeofareaitems[i]['residence_hindi'];
      }
    }
    return title;
  }


  void updateProfile() async {
    setState(() {scroll1=true;});
    var headers = {
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };

    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().updateProfileURL));
    request.fields.addAll({
      'youth_id': intToBase64(userId),
      'name':nameController.text,
      'email':emailController.text,
      'gender':gendersdropdownvalue.toString(),
      'dob':formatDateTime(selectedDate),
      'district':districtdropdownvalue.toString(),
      'location_type':areadropdownvalue.toString(),
      'caste':castedropdownvalue.toString(),
      'employment_status':statusdropdownvalue.toString(),
      'last_qualification':qualificationdropdownvalue.toString(),
      'category':servicedropdownvalue.toString(),
      'state':statedropdownvalue.toString(),
    });

    print('ggggg1----${nameController.text}');
    print('ggggg2----${emailController.text}');
    print('ggggg3----$gendersdropdownvalue');
    print('ggggg4----${formatDateTime(selectedDate)}');
    print('ggggg5----$districtdropdownvalue');
    print('ggggg6----$areadropdownvalue');
    print('ggggg7----$castedropdownvalue');
    print('ggggg8----$statusdropdownvalue');
    print('ggggg9----$qualificationdropdownvalue');
    print('ggggg10---$servicedropdownvalue');
    print('gggg11----$statedropdownvalue');


    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast('User Profile update successful');
        setState(() {scroll1 = false;});
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => userProfile()), (Route<dynamic> route) => false);
      }else{
        if(results['code']==319){
          toasts().redToast('data already updated try again');
          setState(() {scroll1 = false;});
          Navigator.pop(context);
        }else{
          toasts().redToast('Please Try Again');
          setState(() {scroll1 = false;});
          Navigator.pop(context);
        }
      }
    }
    else {
      toasts().redToast('Server Error');
      setState(() {scroll1 = false;});
      Navigator.pop(context);
    }
  }

  String intToBase64(int value) {
    final encoded = base64Encode(utf8.encode(value.toString()));
    return encoded;
  }

  String formatDateTime(DateTime inputDate) {
    final outputFormat = DateFormat('dd-MM-yyyy');
    return outputFormat.format(inputDate);
  }

}
