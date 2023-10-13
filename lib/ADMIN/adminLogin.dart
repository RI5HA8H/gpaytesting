


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/ADMIN/adminHomePage.dart';
import 'package:http/http.dart' as http;
import '../Utilles/allAPI.dart';
import '../Utilles/editText.dart';
import '../Utilles/toasts.dart';
import '../Utilles/url.dart';

class adminLogin extends StatefulWidget {
  const adminLogin({Key? key}) : super(key: key);

  @override
  State<adminLogin> createState() => _adminLoginState();
}

class _adminLoginState extends State<adminLogin> {


  bool scroll = false;
  bool _isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

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
                child: Center(child: Text('adminLogin'.tr, style: TextStyle(fontSize: 24,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),)),
              ),


              Padding(
                padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                child: editTextSimple(controllers: emailController,
                  focusNode: emailFocusNode,
                  hint: 'emailEditText'.tr,
                  keyboardTypes: TextInputType.emailAddress,
                  maxlength: 30,),
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
                    if (emailController.text.isEmpty == true ||
                        passwordController.text.isEmpty == true) {
                      toasts().redToast('warningtoast'.tr);
                    } else {
                      emailFocusNode.unfocus();
                      passwordFocusNode.unfocus();
                      setState(() {scroll = true;});
                      userLogin(emailController.text.toString(), passwordController.text.toString());
                    }
                  },
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

  Future<void> userLogin(String email, String password) async {
    var headers = {
      'access_key': 'PMAT-01H8Y3VD084HCJQC55544V2D2H',
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };
    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().adminLoginURL));
    request.fields.addAll({
      'login_email': email,
      'login_password': password
    });

    request.headers.addAll(headers);

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['data']['code']==200){
        toasts().greenToast('loginSuccessptoast'.tr);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('adminUserID', results['data']['data']['id']);
        prefs.setString('adminUserName', results['data']['data']['name']);
        prefs.setString('adminUserEmail',results['data']['data']['email']);
        prefs.setString('adminUserPhone',results['data']['data']['mobile']);
        prefs.setString('adminUserEmpID',results['data']['data']['employee_id']);
        prefs.setString('adminUserRole',results['data']['data']['role_title']);

        setState(() {scroll = false;});
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => adminHomePage()), (Route<dynamic> route) => false);

      }else{
        if(results['data']['code']==400){
          toasts().redToast(results['data']['msg']);
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
