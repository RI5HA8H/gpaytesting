

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/userProfile.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/editTextWithoutShadow.dart';
import 'Utilles/profileEditText.dart';
import 'Utilles/toasts.dart';
import 'Utilles/url.dart';

class userProfileEdit extends StatefulWidget {
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

  userProfileEdit(this.userName, this.userPhone,this.userEmail, this.dob, this.gender,this.caste,this.service, this.empstatus,this.lastqualification, this.state,this.district, this.typrofarea,);


  @override
  State<userProfileEdit> createState() => _userProfileEditState(userName,userPhone,userEmail,dob,gender,caste,service,empstatus,lastqualification,state,district,typrofarea,);
}

class _userProfileEditState extends State<userProfileEdit> {
  _userProfileEditState(userName,userPhone,userEmail,dob,gender,caste,service,empstatus,lastqualification,state,district,typrofarea,);

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

  var casteItem = [];
  var serviceItem = [];
  var statusItem = [];
  var qualificationItem = [];
  var stateItem = [];
  var districtItem = [];
  var typeofareaItem = [];

  var genderApi;
  var gendersdropdownvalue;
  var castedropdownVal;
  var servicedropdownVal;
  var statusdropdownVal;
  var qualificationdropdownVal;
  var statedropdownVal;
  var districtdropdownVal;
  var areadropdownVal;
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
    genderApi= widget.gender;

    castedropdownVal= widget.caste;
    areadropdownVal= widget.typrofarea;
    statedropdownVal=  widget.state;
    districtdropdownVal=  widget.district;
    servicedropdownVal=  widget.service;
    statusdropdownVal= widget.empstatus;
    qualificationdropdownVal= widget.lastqualification;

    getCaste();
    getAllCategory();
    getEmpStatus();
    getEducation();
    getState();
    getDistrict();
    getPlaceType();
    getLanguage();

    print('ppppppppUN-------${widget.userName}');
    print('ppppppppUM-------${widget.userPhone}');
    print('ppppppppUE-------${widget.userEmail}');
    print('ppppppppG-------${widget.gender}');
    print('ppppppppDOB-------${widget.dob}');
    print('ppppppppC-------${widget.caste}');
    print('ppppppppTOA-------${widget.typrofarea}');
    print('ppppppppS-------${widget.state}');
    print('ppppppppD-------${widget.district}');
    print('ppppppppS-------${widget.service}');
    print('ppppppppES-------${widget.empstatus}');
    print('ppppppppLQ-------${widget.lastqualification}');
    //print('iiiiiiiiiiiii${getQualificationName(int.parse('$qualificationdropdownVal'))}');
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        elevation: 0,
      ),
      body:  Container(
        padding: EdgeInsets.only(top: 10),
        color: appcolors.primaryColor,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
            child: scroll1 || scroll2 || scroll3 || scroll4 || scroll5 || scroll6 || scroll7 ? Center(child: CircularProgressIndicator(strokeWidth: 3,)) : ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Container(
                          height: 40,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            maxLength: 50,
                            textAlignVertical: TextAlignVertical.bottom,
                            keyboardType:TextInputType.text,
                            controller: nameController,
                            focusNode: nameFocusNode,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Color(0xffC5C5C5),
                                    width: 0.5,
                                  ),
                                ),

                                counterText: '',
                                labelText: '',
                                hintText: 'username'.tr,
                                hintStyle: TextStyle(fontSize: 12),
                            ),
                            style: TextStyle(fontSize: 12,),
                            textAlign: TextAlign.left,
                          ),
                      ),

                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                        ),
                        child: TextField(
                          maxLength: 50,
                          keyboardType:TextInputType.emailAddress,
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: emailController,
                          focusNode: emailFocusNode,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color(0xffC5C5C5), // Border color
                                  width: 0.5,         // Border width
                                ),
                              ),
                              counterText: '',
                              labelText: '',
                              hintText: 'useremail'.tr,
                              hintStyle: TextStyle(fontSize: 12),
                            alignLabelWithHint: false,
                          ),
                          style: TextStyle(fontSize: 12,),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                        ),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color(0xffC5C5C5), // Border color
                                  width: 0.5,         // Border width
                                ),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon:GestureDetector(child: Icon(Icons.calendar_month),
                              ),
                              //labelText: "DOB - ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                              hintText: 'DOB : ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                              hintStyle: TextStyle(fontSize: 12,color: Colors.black,)
                          ),
                          onTap: (){
                            _selectDate(context);
                            studobController="${selectedDate.toLocal()}".split(' ')[0];
                            print('ttttttttt$studobController');
                          },
                        ),
                      ),


                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffC5C5C5),
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(genderApi!=null ? getGenderName(genderApi) : "gender".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                            iconStyleData: IconStyleData(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.keyboard_arrow_down),
                                ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 1,
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

                            items: genderitems.map((item101) {
                              return DropdownMenuItem(
                                value: item101.toString(),
                                child: Text(item101.toString(),style: TextStyle(fontSize: 12,),
                              ));
                            }).toList(),
                            onChanged: (newVal101) {
                              setState(() {
                                if(newVal101=='male'.tr){
                                  genderApi = '1';
                                  print('vvvv=------$newVal101');
                                  print('gggg=------$genderApi');
                                }else{
                                  if(newVal101=='female'.tr){
                                    genderApi = '2';
                                    print('vvvv=------$newVal101');
                                    print('gggg=------$genderApi');
                                  }else{
                                    genderApi = '3';
                                    print('vvvv=------$newVal101');
                                    print('gggg=------$genderApi');
                                  }
                                }
                                //gendersdropdownvalue = 'M';
                              });
                            },
                            value: gendersdropdownvalue,
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffC5C5C5),
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(castedropdownVal!=null ? getCastName(int.parse('$castedropdownVal')) : "caste".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                            iconStyleData: IconStyleData(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.keyboard_arrow_down),
                                ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 1,
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
                            items: casteItem.map((item102) {
                              return DropdownMenuItem(
                                value: item102['id'],
                                child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item102['caste_title_eng'] : item102['caste_title_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              );
                            }).toList(),
                            onChanged: (newVal102) {
                              setState(() {
                                castedropdownVal = newVal102;
                                print('caassstttttttttttttt----$castedropdownVal');
                              });
                            },
                            value: castedropdownVal,
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffC5C5C5),
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(servicedropdownVal!=null ? getServiceName(int.parse('$servicedropdownVal')) : "service".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                            iconStyleData: IconStyleData(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.keyboard_arrow_down),
                                )
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 1,
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
                            items: serviceItem.map((item103) {
                              return DropdownMenuItem(
                                value: item103['id'],
                                child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item103['service_title_eng'] : item103['service_title_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              );
                            }).toList(),
                            onChanged: (newVal103) {
                              setState(() {
                                servicedropdownVal = newVal103;
                              });
                            },
                            value: servicedropdownVal,
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffC5C5C5),
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(statusdropdownVal!=null ? getStatusName(int.parse('$statusdropdownVal')) : "empstatus".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                            iconStyleData: IconStyleData(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.keyboard_arrow_down),
                                )
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 1,
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
                            items: statusItem.map((item104) {
                              return DropdownMenuItem(
                                value: item104['id'],
                                child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item104['status_english'] : item104['status_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              );
                            }).toList(),
                            onChanged: (newVal104) {
                              setState(() {
                                statusdropdownVal = newVal104;
                              });
                            },
                            value: statusdropdownVal,
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffC5C5C5),
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(statedropdownVal!=null  ? getStateName(int.parse('$statedropdownVal')) : "state".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                            iconStyleData: IconStyleData(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.keyboard_arrow_down),
                                )
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 1,
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
                            items: stateItem.map((item106) {
                              return DropdownMenuItem(
                                value: item106['id'],
                                child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item106['state_eng_name'] : item106['state_hindi_name'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              );
                            }).toList(),
                            onChanged: (newVal106) {
                              setState(() {
                                statedropdownVal = newVal106;
                              });
                            },
                            value: statedropdownVal,
                          ),
                        ),
                      ),

                       SizedBox(height: 5,),
                       Container(
                         height: 40,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(5),
                           border: Border.all(
                             color: Color(0xffC5C5C5),
                             width: 0.5,
                           ),
                         ),
                         child: DropdownButtonHideUnderline(
                           child: DropdownButton2(
                             isExpanded: true,
                            hint: Text(districtdropdownVal!=null ? getDistrictName(int.parse('$districtdropdownVal')) : "district".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                             iconStyleData: IconStyleData(
                                 icon: Padding(
                                   padding: const EdgeInsets.only(right: 16),
                                   child: Icon(Icons.keyboard_arrow_down),
                                 )
                             ),
                             dropdownStyleData: DropdownStyleData(
                               elevation: 1,
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
                             items: districtItem.map((item107) {
                              return DropdownMenuItem(
                                value: item107['id'],
                                child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item107['district_title_eng'] : item107['district_title_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              );
                            }).toList(),
                            onChanged: (newVal107) {
                              setState(() {
                                districtdropdownVal = newVal107;
                              });
                            },
                            value: districtdropdownVal,
                      ),
                         ),
                       ),

                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffC5C5C5),
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(areadropdownVal!=null ? getTypeOfAreaName(int.parse('$areadropdownVal')): "typrofarea".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                            iconStyleData: IconStyleData(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.keyboard_arrow_down),
                                )
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 1,
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
                            items: typeofareaItem.map((item108) {
                              return DropdownMenuItem(
                                value: item108['id'],
                                child: Container(width: MediaQuery.of(context).size.width/2,child: Text(engLanguage ? item108['residence_english'] : item108['residence_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              );
                            }).toList(),
                            onChanged: (newVal108) {
                              setState(() {
                                areadropdownVal = newVal108;
                              });
                            },
                            value: areadropdownVal,
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xffC5C5C5),
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(qualificationdropdownVal!=null ? getQualificationName(int.parse('$qualificationdropdownVal')) : "lastqualification".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                            iconStyleData: IconStyleData(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(Icons.keyboard_arrow_down),
                                )
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 1,
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
                            items: qualificationItem.map((item105) {
                              return DropdownMenuItem(
                                value: item105['id'],
                                child: Container(width: MediaQuery.of(context).size.width/1.8,child: Text(engLanguage ? item105['education_title_eng'] : item105['education_title_hindi'],style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              );
                            }).toList(),
                            onChanged: (newVal105) {
                              setState(() {
                                qualificationdropdownVal = newVal105;
                              });
                            },
                            value: qualificationdropdownVal,
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Container(
                          padding: EdgeInsets.only(left: 0,right: 0),
                          child: InkWell(
                            child: Container(
                                height: 40,
                                width: double.infinity,
                                color: Colors.green,
                                child: Center(child: Text('updateProfile'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white)))),
                            onTap: () async {
                              if(nameController.text.isEmpty || emailController.text.isEmpty ){
                                toasts().redToast('warningtoast'.tr);
                              }else {
                                updateProfile();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
          casteItem = getitems;
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
          serviceItem = getitems;
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
          statusItem = getitems;
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
          qualificationItem = getitems;
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
          stateItem = getitems;
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
          districtItem = getitems;
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
          typeofareaItem = getitems;
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

  String getGenderName(String id){
    String title='';
    if(id=='1'){
      genderApi=id;
      title=genderitems[0];
    }else{
      if(id=='2'){
        genderApi=id;
        title=genderitems[1];
      }else{
        genderApi=id;
        title=genderitems[2];
      }
    }


    return title;
  }

  String getCastName(int id){
    String title='';
    for(int i=0;i<casteItem.length;i++){
      if(casteItem[i]['id']==id){
        castedropdownVal=id;
        title=engLanguage ? casteItem[i]['caste_title_eng'] : casteItem[i]['caste_title_hindi'];
        break;
      }
    }
    return title;
  }

  String getServiceName(int id){
    String title='';
    for(int i=0;i<serviceItem.length;i++){
      if(serviceItem[i]['id']==id){
        servicedropdownVal=id;
        title=engLanguage ? serviceItem[i]['service_title_eng'] : serviceItem[i]['service_title_hindi'];
        break;
      }
    }
    return title;
  }

  String getStatusName(int id){
    String title='';
    for(int i=0;i<statusItem.length;i++){
      if(statusItem[i]['id']==id){
        statusdropdownVal=id;
        title=engLanguage ? statusItem[i]['status_english'] : statusItem[i]['status_hindi'];
        break;
      }
    }
    return title;
  }

  String getQualificationName(int id){
    String title='';
    for(int i=0;i<qualificationItem.length;i++){
      if(qualificationItem[i]['id']==id){
        qualificationdropdownVal=id;
        title=engLanguage ? qualificationItem[i]['education_title_eng'] : qualificationItem[i]['education_title_hindi'];
        break;
      }
    }
    return title;
  }

  String getStateName(int id){
    String title='';
    for(int i=0;i<stateItem.length;i++){
      if(stateItem[i]['id']==id){
        statedropdownVal=id;
        title=engLanguage ? stateItem[i]['state_eng_name'] : stateItem[i]['state_hindi_name'];
        break;
      }
    }
    return title;
  }

  String getDistrictName(int id){
    String title='';
    for(int i=0;i<districtItem.length;i++){
      if(districtItem[i]['id']==id){
        districtdropdownVal=id;
        title=engLanguage ? districtItem[i]['district_title_eng'] : districtItem[i]['district_title_hindi'];
        break;
      }
    }
    return title;
  }

  String getTypeOfAreaName(int id){
    String title='';
    for(int i=0;i<typeofareaItem.length;i++){
      if(typeofareaItem[i]['id']==id){
        areadropdownVal=id;
        title=engLanguage ? typeofareaItem[i]['residence_english'] : typeofareaItem[i]['residence_hindi'];
        break;
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
      'gender':genderApi,
      'dob':formatDateTime(selectedDate),
      'district':districtdropdownVal.toString(),
      'location_type':areadropdownVal.toString(),
      'caste':castedropdownVal.toString(),
      'employment_status':statusdropdownVal.toString(),
      'last_qualification':qualificationdropdownVal.toString(),
      'category':servicedropdownVal.toString(),
      'state':statedropdownVal.toString(),
    });

    print('ggggg1----${nameController.text}');
    print('ggggg2----${emailController.text}');
    print('ggggg3----${genderApi}');
    print('ggggg4----${formatDateTime(selectedDate)}');
    print('ggggg5----$districtdropdownVal');
    print('ggggg6----$areadropdownVal');
    print('ggggg7----$castedropdownVal');
    print('ggggg8----$statusdropdownVal');
    print('ggggg9----$qualificationdropdownVal');
    print('ggggg10---$servicedropdownVal');
    print('gggg11----$statedropdownVal');


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
