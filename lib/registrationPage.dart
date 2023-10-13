import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/previousHomePage.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/editText.dart';
import 'Utilles/toasts.dart';
import 'Utilles/url.dart';
import 'loginPage.dart';

class registrationPage extends StatefulWidget {
  const registrationPage({Key? key}) : super(key: key);

  @override
  State<registrationPage> createState() => _registrationPageState();
}

class _registrationPageState extends State<registrationPage> {
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
    double screenHeight = MediaQuery.of(context).size.height;
    return  scroll ? Scaffold(body: Center(child: CircularProgressIndicator())) : Scaffold(
      body: Container(
        height: otpScroll ? screenHeight : screenHeight*0.75,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Image.asset('assets/icons/yuvalogo.png',height: 100,width: 250,),
                ),
              ),

              /*Padding(
                padding: EdgeInsets.fromLTRB(30, 10,30, 10),
                child: Center(child: Text('registration'.tr, style: TextStyle(fontSize: 30, color: Colors.orange,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)),
              ),*/

              Padding(
                padding: EdgeInsets.fromLTRB(40, 0,40, 0),
                child: Center(child: Text('singupheading'.tr, style: TextStyle(fontSize: 16, color: Colors.black),textAlign: TextAlign.center,)),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10,20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('ifregisterthenlogin'.tr,style: TextStyle(fontSize: 14,color: Color(0xff2A2A2A))),
                    ElevatedButton(
                      child: SizedBox(width: MediaQuery.of(context).size.width/8,height: 16,child: Center(child: Text('onlylogin'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.white)))),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange),),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                      },
                    ),
                  ],
                )
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(40, 0,40, 5),
                child: Center(child: Text('step1subheading'.tr, style: TextStyle(fontSize: 12, color: Colors.black),textAlign: TextAlign.center,)),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(40,5,40,5),
                child: editTextSimple(controllers: mobileController,focusNode: numberFocusNode,hint:'mobileEditText'.tr,keyboardTypes: TextInputType.number,maxlength: 10 ,),
              ),

              otpScroll ?

              Column(
                children: [

                  Padding(
                    padding: EdgeInsets.fromLTRB(40,5,40,5),
                    child: editTextSimple(controllers: otpController,focusNode: otpFocusNode,hint:'otpEditText'.tr,keyboardTypes: TextInputType.number,maxlength: 6 ,),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(40,5,40,5),
                    child: editTextSimple(controllers: nameController,focusNode: numberFocusNode,hint:'nameEditText'.tr,keyboardTypes: TextInputType.text,maxlength: 30 ,),
                  ),

                  Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(40,5,40,5),
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
                    padding: EdgeInsets.fromLTRB(40,5,40,5),
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
                    padding: EdgeInsets.fromLTRB(40,5,40,5),
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
                    padding: const EdgeInsets.fromLTRB(40, 10,40, 10),
                    child: ElevatedButton(
                      child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('register'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white)))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.orange),
                      ),
                      onPressed: (){
                        if(mobileController.text.isEmpty==true || otpController.text.isEmpty==true || nameController.text.isEmpty==true || categoryDropdownvalue==null || passwordController.text.isEmpty==true || cpasswordController.text.isEmpty==true ){
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

                  Container(
                    height: screenHeight*0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/login-bg.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                ],
              ) :

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 5,40, 5),
                    child: ElevatedButton(
                      child: SizedBox(width: MediaQuery.of(context).size.width/3,height: 40,child: Center(child: Text('sendotp'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white)))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff1FA36B)),
                      ),
                      onPressed: (){
                        if(mobileController.text.length!=10 ){
                          toasts().redToast('warningtoast'.tr);
                        }else{
                          setState(() {scroll=true;});
                          sendOTP(mobileController.text.toString());
                        }
                      },
                    ),
                  ),
                  /*Padding(
                    padding: EdgeInsets.fromLTRB(40, 0,40, 0),
                    child: Text('otpNoText'.tr, style: TextStyle(fontSize: 14, color: Color(0xff7A869A)),textAlign: TextAlign.left,),
                  ),*/

                ],
              ) ,
            ],
          ),
        ),
      ),
      bottomNavigationBar: otpScroll ? Container(height: 0,) : Container(
        height: screenHeight*0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login-bg.png"),
            fit: BoxFit.fill,
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
      //print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast(results['msg']);
        setState(() {
          otpScroll = true;
          scroll = false;
          print('oootttpppp----$otpScroll');
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
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginPage()), (Route<dynamic> route) => false);
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

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);

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
