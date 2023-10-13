


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Utilles/editText.dart';
import 'Utilles/toasts.dart';
import 'loginPage.dart';

class forgetPassword extends StatefulWidget {
  const forgetPassword({Key? key}) : super(key: key);

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {

  bool scroll = false;
  bool _isObscure = true;
  TextEditingController mobileController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return scroll ? Scaffold(body: Center(child: CircularProgressIndicator())) :  Scaffold(
      body: Container(
        height: screenHeight*0.75,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Image.asset('assets/icons/yuvalogo.png',height: 100,width: 250,),
                  ),
                ),
                SizedBox(height: 10,),
                Center(child: Text('resetPassword'.tr, style: TextStyle(fontSize: 30, color: Colors.orange,fontWeight: FontWeight.bold),)),
               // Center(child: Text('startnow'.tr, style: TextStyle(fontSize: 14, color: Colors.grey),)),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.fromLTRB(40,5,40,5),
                  child: editTextSimple(controllers: mobileController,focusNode: mobileFocusNode,hint:'mobileEditText'.tr,keyboardTypes: TextInputType.number,maxlength: 10 ,),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10,40, 10),
                  child: ElevatedButton(
                    child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('sendotp'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white)))),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: (){
                      if(mobileController.text.isEmpty==true ){
                        toasts().redToast('warningtoast'.tr);
                      }else{
                        toasts().greenToast('otpSuccessptoast'.tr);
                        mobileFocusNode.unfocus();
                        setState(() {
                          //scroll=true;
                        });
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => searchResults()));
                      }
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0,40, 0),
                  child: Text('otpNoText'.tr, style: TextStyle(fontSize: 14, color: Color(0xff7A869A)),textAlign: TextAlign.left,),
                ),

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: InkWell(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(text: 'getOTP'.tr,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange)),
                            TextSpan(text: 'login'.tr, style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue ))
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
        height: screenHeight*25,
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
}
