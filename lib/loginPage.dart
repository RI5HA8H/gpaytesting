


import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Utilles/allAPI.dart';
import 'package:yuvasathi/Utilles/url.dart';
import 'package:yuvasathi/previousHomePage.dart';
import 'package:yuvasathi/registrationPage.dart';
import 'package:http/http.dart' as http;
import 'Utilles/checkInternet.dart';
import 'Utilles/editText.dart';
import 'Utilles/toasts.dart';
import 'forgetPassword.dart';
import 'homePage.dart';
import 'otpLogin.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {


  bool scroll = false;
  bool _isObscure = true;
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  StreamSubscription? internetconnection;
  bool isoffline = false;
  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
          print(T);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        setState(() {
          isoffline = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => checkInternet()));
        });
      });
    }
  }

  void initState() {
    super.initState();
    CheckUserConnection();
    _checkVersion();
    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => checkInternet()));
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
      super.initState();
    });
  }

  @override
  void dispose() {
    internetconnection!.cancel();
    super.dispose();
  }

  void _checkVersion() async {

    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return scroll
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
        body: Container(
            height: screenHeight*0.75,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 60,),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/yuvalogo.png', height: 100, width: 250,),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Text('onlylogin'.tr, style: TextStyle(fontSize: 30,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),)),
                  ),


                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: editTextSimple(controllers: mobileController,
                      focusNode: mobileFocusNode,
                      hint: 'mobileEditText'.tr,
                      keyboardTypes: TextInputType.number,
                      maxlength: 10,),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffC5C5C5).withOpacity(0.5),
                            // Shadow color
                            spreadRadius: 2,
                            // Spread radius
                            blurRadius: 5,
                            // Blur radius
                            offset: Offset(0, 3), // Offset in the Y direction
                          ),
                        ],
                      ),
                      child: TextField(
                        maxLength: 10,
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xffC5C5C5), // Border color
                                width: 0.5, // Border width
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            counterText: "",
                            //  labelText: 'Password',
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _isObscure ? Icons.visibility : Icons
                                        .visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            hintText: 'passwordEditText'.tr,
                            hintStyle: TextStyle(fontSize: 12)
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Container(alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Text('otpLogin'.tr, style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12)),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => otpLogin()));
                          },
                        )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: ElevatedButton(
                      child: SizedBox(width: double.infinity,
                          height: 50,
                          child: Center(child: Text(
                              'login'.tr, style: TextStyle(fontWeight: FontWeight
                              .bold, fontSize: 14, color: Colors.white)))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () {
                        if (mobileController.text.isEmpty == true || passwordController.text.isEmpty == true) {
                          toasts().redToast('warningtoast'.tr);
                        } else {
                          mobileFocusNode.unfocus();
                          passwordFocusNode.unfocus();
                          setState(() {scroll = true;});
                          userLogin(mobileController.text.toString(), passwordController.text.toString());
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: InkWell(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(text: 'noaccount'.tr,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.orange)),
                              TextSpan(text: 'register'.tr,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.blue))
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => registrationPage()));
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        bottomNavigationBar:  Container(
        height: MediaQuery.of(context).size.height*0.25,
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

  Future<void> userLogin(String mobileNo, String password) async {
    var headers = {
      'access_key': 'PMAT-01H8Y3VD084HCJQC55544V2D2H',
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };
    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().loginURL));
    request.fields.addAll({
      'mobile_number': mobileNo,
      'password': password
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
        prefs.setString('userVerify',results['data']['is_verify']);

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