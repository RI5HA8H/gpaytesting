


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/previousHomePage.dart';
import 'package:http/http.dart' as http;
import 'package:yuvasathi/registrationPage.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/editText.dart';
import 'Utilles/toasts.dart';
import 'Utilles/url.dart';
import 'loginPage.dart';

class otpLogin extends StatefulWidget {
  const otpLogin({Key? key}) : super(key: key);

  @override
  State<otpLogin> createState() => _otpLoginState();
}

class _otpLoginState extends State<otpLogin> {
  bool scroll = false;
  String apiOTP = '';
  bool _isObscure = true;
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return scroll ? Scaffold(body: Center(child: CircularProgressIndicator())) : Scaffold(
      body: Container(
        height: screenHeight*0.75,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Image.asset('assets/icons/yuvalogo.png',height: 100,width: 250,),
                  ),
                ),
                Center(child: Text('otpLogin'.tr, style: TextStyle(fontSize: 24, color: Colors.orange,fontWeight: FontWeight.bold),)),
                // Center(child: Text('startnow'.tr, style: TextStyle(fontSize: 14, color: Colors.grey),)),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.fromLTRB(40,5,40,5),
                  child: editTextSimple(controllers: mobileController,focusNode: mobileFocusNode,hint:'mobileEditText'.tr,keyboardTypes: TextInputType.number,maxlength: 10 ,),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 5,40, 5),
                  child: ElevatedButton(
                    child: SizedBox(width: MediaQuery.of(context).size.width,height: 40,child: Center(child: Text('sendotp'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white)))),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(40,5,40,5),
                  child: editTextSimple(controllers: otpController,focusNode: otpFocusNode,hint:'otpEditText'.tr,keyboardTypes: TextInputType.number,maxlength: 6 ,),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5,40, 5),
                  child: ElevatedButton(
                    child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('login'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white)))),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: (){
                      if(mobileController.text.isEmpty==true  || otpController.text.isEmpty==true ){
                        toasts().redToast('warningtoast'.tr);
                      }else{
                        if(otpController.text==apiOTP){
                          mobileFocusNode.unfocus();
                          otpFocusNode.unfocus();
                          setState(() {scroll = true;});
                          otpLogin(mobileController.text.toString(), otpController.text.toString());
                          }else{
                          toasts().redToast('OTP does not match');
                        }
                      }
                    },
                  ),
                ),

               /* Padding(
                  padding: EdgeInsets.fromLTRB(40, 0,40, 0),
                  child: Text('otpNoText'.tr, style: TextStyle(fontSize: 14, color: Color(0xff7A869A)),textAlign: TextAlign.left,),
                ),*/

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: InkWell(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(text: 'otpPassword'.tr,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange)),
                            TextSpan(text: 'clickhere'.tr, style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue ))
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
        toasts().redToast('noNotMatchMsg'.tr);
        setState(() {scroll = false;});
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => registrationPage()));
      }else{
        if(results['code']==400){
          toasts().redToast(results['msg']);
          setState(() {scroll = false;});
        }else{
          if(results['code']==204){
            toasts().greenToast('otpSendMsg'.tr);
            setState(() {scroll = false;});
            apiOTP = results['otp'].toString();
            print('ootp------$apiOTP');
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

  Future<void> otpLogin(String mobileNo, String otp) async {
    var headers = {
      'access_key': 'PMAT-01H8Y3VD084HCJQC55544V2D2H',
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };
    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().otploginURL));
    request.fields.addAll({
      'mobile_number': mobileNo,
      'otp': otp
    });

    request.headers.addAll(headers);

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast('loginSuccessptoast'.tr);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('userID', results['data']['id']);
        prefs.setString('userName', results['data']['name']);
        //prefs.setString('userEmail',results['data']['email']);
        prefs.setString('userPhone',results['data']['mobile']);
       // prefs.setString('userVerify',results['data']['is_verify']);

        setState(() {scroll = false;});

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);

      }else{
        if(results['code']==400){
          toasts().redToast(results['msg']);
          setState(() {scroll = false;});
        }else{
          toasts().redToast('Please Try Again');
          setState(() {scroll = false;});
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
