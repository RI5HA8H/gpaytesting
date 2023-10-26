

import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import '../Utilles/allAPI.dart';
import '../Utilles/editText.dart';
import '../Utilles/footer.dart';
import '../Utilles/helplineCardView.dart';
import '../Utilles/toasts.dart';
import '../Utilles/url.dart';
import '../homePage.dart';
import '../loginPage.dart';
import 'findSchemeStepSeaven.dart';
import 'findSchemeStepTwo.dart';


class findSchemeStepOne extends StatefulWidget {
  const findSchemeStepOne({Key? key}) : super(key: key);

  @override
  State<findSchemeStepOne> createState() => _findSchemeStepOneState();
}

class _findSchemeStepOneState extends State<findSchemeStepOne> {
  bool engLanguage = true;
  String apiOTP = '';
  bool scroll = false;
  bool otpScroll = false;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode numberFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode cpasswordFocusNode = FocusNode();

  var categoryDropdownList=[];
  var categoryDropdownvalue;

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
            title: Container(padding: EdgeInsets.only(left: 10,right: 10),child: Center(child: Text('appbarSecondTitle'.tr,style: TextStyle(fontSize: 9,color: Colors.white),textAlign: TextAlign.center,maxLines: 3,))),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back,size: 20,),
                              SizedBox(width: 5,),
                              Text('backButton'.tr),
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage()), (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  ),*/
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20,20, 0),
                        child: Text('step1'.tr, style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold,),),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0,20, 0),
                        child: Divider(color: Colors.black,),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0,20, 0),
                        child: Text('step1heading'.tr, style: TextStyle(fontSize: 18, color: Color(0xff7959AC),fontWeight: FontWeight.bold,),),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0,20, 0),
                        child: InkWell(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(text: 'ifregisterthenlogin'.tr,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange)),
                                TextSpan(text: 'login'.tr, style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue ))
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(20,5,20,5),
                        child: Text('step1subheading'.tr, style: TextStyle(fontSize: 8, color: Colors.grey),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child:  Center(child: Image.asset('assets/images/rbb1.png',fit: BoxFit.fill,width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/2,)),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(20,5,20,5),
                        child: editTextSimple(controllers: nameController, focusNode: nameFocusNode,hint: 'nameEditText'.tr, keyboardTypes: TextInputType.text, maxlength: 50,),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(20,5,20,5),
                        child: editTextSimple(controllers: mobileController, focusNode: numberFocusNode, hint: 'mobileEditText'.tr, keyboardTypes: TextInputType.number, maxlength: 10,),
                      ),

                      otpScroll ?

                      Column(
                        children: [

                          Padding(
                            padding: EdgeInsets.fromLTRB(20,5,20,5),
                            child: editTextSimple(controllers: otpController, focusNode: otpFocusNode, hint: 'otpEditText'.tr, keyboardTypes: TextInputType.number, maxlength: 6,),
                          ),

                          Container(
                            height: 60,
                            padding: EdgeInsets.fromLTRB(20,5,20,5),
                            child:DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text('searchtextsubhead1'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                                isExpanded: true,
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: MediaQuery.of(context).size.height/2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                  ),
                                ),
                                iconStyleData: IconStyleData(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    )
                                ),
                                buttonStyleData: ButtonStyleData(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffC5C5C5), width: 0.5,),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                ),
                                items: categoryDropdownList.map((item) {
                                  return DropdownMenuItem(
                                    value: item['id'].toString(),
                                    child: Text(engLanguage ? item['service_title_eng'] : item['service_title_hindi'],style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    categoryDropdownvalue = newVal;
                                    print('ggggggg---$newVal');
                                  });
                                },
                                value: categoryDropdownvalue,
                              ),
                            ),

                          ),

                          Padding(
                            padding: EdgeInsets.fromLTRB(20,5,20,5),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffC5C5C5).withOpacity(0.5), // Shadow color
                                    spreadRadius: 2,                     // Spread radius
                                    blurRadius: 5,                       // Blur radius
                                    offset: Offset(0, 3),                // Offset in the Y direction
                                  ),
                                ],
                              ),
                              child: TextField(
                                maxLength: 10,
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                obscureText: _isObscure1,
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
                                    counterText: "",
                                    //  labelText: 'Password',
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                            _isObscure1 ? Icons.visibility : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure1 = !_isObscure1;
                                          });
                                        }),
                                    hintText: 'passwordEditText'.tr,
                                    hintStyle: TextStyle(fontSize: 12)
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.fromLTRB(20,5,20,5),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffC5C5C5).withOpacity(0.5), // Shadow color
                                    spreadRadius: 2,                     // Spread radius
                                    blurRadius: 5,                       // Blur radius
                                    offset: Offset(0, 3),                // Offset in the Y direction
                                  ),
                                ],
                              ),
                              child: TextField(
                                maxLength: 10,
                                controller: cpasswordController,
                                focusNode: cpasswordFocusNode,
                                obscureText: _isObscure2,
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
                                    counterText: "",
                                    //  labelText: 'Password',
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                            _isObscure2 ? Icons.visibility : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure2 = !_isObscure2;
                                          });
                                        }),
                                    hintText: 'passwordEditText'.tr,
                                    hintStyle: TextStyle(fontSize: 12)
                                ),
                              ),
                            ),
                          ),


                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 30,20, 10),
                            child: ElevatedButton(
                              child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('register'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)))),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color(0xff7959AC)),
                              ),
                              onPressed: () {
                                if(mobileController.text.length!=10  || nameController.text.isEmpty==true  || otpController.text.isEmpty==true || categoryDropdownvalue==null || passwordController.text.isEmpty==true || cpasswordController.text.isEmpty==true ){
                                  toasts().redToast('warningtoast'.tr);
                                }else{
                                  if(otpController.text==apiOTP){
                                    nameFocusNode.unfocus();
                                    numberFocusNode.unfocus();
                                    otpFocusNode.unfocus();
                                    passwordFocusNode.unfocus();
                                    cpasswordFocusNode.unfocus();
                                    setState(() {scroll=true;});
                                    userSingup(mobileController.text.toString(),apiOTP,nameController.text.toString(),categoryDropdownvalue.toString(),passwordController.text.toString(),cpasswordController.text.toString());
                                  }else{
                                    toasts().redToast('OTP does not match');
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      )    :
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 30,20, 10),
                        child: ElevatedButton(
                          child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('sendotp'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)))),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff7959AC)),
                          ),
                          onPressed: (){
                            if(mobileController.text.length!=10  || nameController.text.isEmpty==true){
                              toasts().redToast('warningtoast'.tr);
                            }else{
                              setState(() {scroll=true;});
                              sendOTP(mobileController.text.toString());
                            }
                          },
                        ),
                      ),
                    ],
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

  Future<void> getAllCategory() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().allCategoryURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        var getitems=results['data'];
        setState(() {
          categoryDropdownList = getitems;
          scroll = false;
        });
        //something
      }else{
        toasts().redToast('Please Try Again');
        setState(() {scroll = false;});
      }
    }
    else {
      toasts().redToast('Server Error');
      setState(() {scroll = false;});
    }
  }

  Future<void> sendOTP(String mobileNo) async {
    var headers = {
      'access_key': 'PMAT-01H8Y3VD084HCJQC55544V2D2H',
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };
    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().checkMobNoURL));
    request.fields.addAll({
      'mobile_number': mobileNo,
    });

    request.headers.addAll(headers);

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast(results['msg']);
        setState(() {
          scroll = false;
          otpScroll = true;
        });
        apiOTP = results['otp'].toString();

      }else{
        if(results['code']==400){
          toasts().redToast(results['msg']);
          setState(() {scroll = false;});
        }else{
          if(results['code']==204){
            toasts().redToast(results['msg']);
            setState(() {scroll = false;});
            //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginPage()), (Route<dynamic> route) => false);
          }else{
            toasts().redToast('Please Try Again');
            setState(() {scroll = false;});
          }
        }
      }
    }
    else {
      toasts().redToast('Server Error');
      setState(() {scroll = false;});
    }
  }


  Future<void> userSingup(String mobileNo, String otp,String name, String category,String password, String cpassword) async {
    var headers = {
      'access_key': 'PMAT-01H8Y3VD084HCJQC55544V2D2H',
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };
    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().singupURL));
    request.fields.addAll({
      'mobile_number': mobileNo,
      'otp': otp,
      'name': name,
      'category': category,
      'password': password,
      'confirm_password': cpassword,
    });

    request.headers.addAll(headers);

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast(results['msg']);
        setState(() {scroll = false;});

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('userID', results['data']['id']);
        prefs.setString('userName', results['data']['name']);
        //prefs.setString('userEmail',results['data']['email']);
        prefs.setString('userPhone',results['data']['mobile']);
        //prefs.setString('userVerify',results['data']['is_verify']);

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepTwo()));

      }else{
        if(results['code']==400){
          toasts().redToast(results['msg']);
          setState(() {scroll = false;});
        }else{
          if(results['code']==502){
            toasts().redToast(results['msg']);
            setState(() {scroll = false;});
          }else{
            if(results['code']==501){
              toasts().redToast(results['msg']);
              setState(() {scroll = false;});
            }else{
              toasts().redToast('Please Try Again');
              setState(() {scroll = false;});
            }
          }
        }
      }
    }
    else {
      toasts().redToast('Server Error');
      setState(() {
        scroll = false;
      });
    }
  }

}
