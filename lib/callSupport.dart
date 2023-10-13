


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:yuvasathi/Utilles/primaryActions.dart';
import 'Utilles/action.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/appbarFloatingButton.dart';
import 'Utilles/bottomNavigation.dart';
import 'Utilles/editText.dart';
import 'Utilles/editTextWithoutShadow.dart';
import 'Utilles/helplineCardView.dart';
import 'Utilles/iconSearchbar.dart';
import 'Utilles/toasts.dart';
import 'Utilles/url.dart';

class callSupport extends StatefulWidget {
  const callSupport({Key? key}) : super(key: key);

  @override
  State<callSupport> createState() => _callSupportState();
}

class _callSupportState extends State<callSupport> {

  bool scroll = false;
  bool isKeyboardVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode subFocusNode = FocusNode();
  FocusNode msgFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibility(
        onChanged: (bool visible) {
          setState(() {
            isKeyboardVisible = visible;
          });
        },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 20.0,
          shadowColor: Colors.transparent,
          backgroundColor: appcolors.primaryColor,
          iconTheme: IconThemeData(color:appcolors.whiteColor),
          title: Image.asset('assets/icons/yuvalogo.png',width: 150,height: 50,fit:BoxFit.fill,color: Colors.white,),
          actions: [primaryActions()],
        ),
        body: scroll
            ? Center(child: CircularProgressIndicator())
            :  SingleChildScrollView(
          child: Container(
            color: appcolors.primaryColor,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    color:appcolors.primaryColor,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/12),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 60,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20,20,20, 0),
                                        child: Text('helpLineHeading'.tr, style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.left,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 20,20, 20),
                                        child: ElevatedButton(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.call,color: Colors.white,),
                                                SizedBox(width: 10,),
                                                Text('+91-9005604448',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                                              ],
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Color(0xff008180)),
                                          ),
                                          onPressed: () async {
                                            final call = Uri.parse('tel:+91 9005604448');
                                            if (await canLaunchUrl(call)) {
                                            launchUrl(call);
                                            } else {
                                            throw 'Could not launch $call';
                                            }
                                          },
                                        ),
                                      ) ,
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 25,bottom: 10,top: 10),
                                        child: Row(
                                          children: [
                                            Icon(Icons.co_present,color: Colors.black,),
                                            SizedBox(width: 10,),
                                            Text('inquiry'.tr, style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: editTextWithoutShadow(
                                          controllers: nameController,
                                          focusNode: nameFocusNode,
                                          hint: 'nameEditText'.tr,
                                          keyboardTypes: TextInputType.text,
                                          maxlength: 50,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: editTextWithoutShadow(
                                          controllers: emailController,
                                          focusNode: emailFocusNode,
                                          hint: 'emailEditText'.tr,
                                          keyboardTypes: TextInputType.emailAddress,
                                          maxlength: 50,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: editTextWithoutShadow(
                                          controllers: subController,
                                          focusNode: subFocusNode,
                                          hint: 'subjectEditText'.tr,
                                          keyboardTypes: TextInputType.text,
                                          maxlength: 100,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: Container(
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                                          ),
                                          child: TextField(
                                            maxLines: 2,
                                            maxLength: 500,
                                            keyboardType:TextInputType.text,
                                            controller: msgController,
                                            focusNode: msgFocusNode,
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
                                                counterText: '',
                                                labelText: '',
                                                hintText:'msgEditText'.tr,
                                                hintStyle: TextStyle(fontSize: 12)
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 20,20, 20),
                                        child: ElevatedButton(
                                          child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('sendmsg'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)))),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.green),
                                          ),
                                          onPressed: (){
                                            if(nameController.text.isEmpty==true || emailController.text.isEmpty==true || subController.text.isEmpty==true || msgController.text.isEmpty==true){
                                              toasts().redToast('warningtoast'.tr);
                                            }else{
                                              nameFocusNode.unfocus();
                                              emailFocusNode.unfocus();
                                              subFocusNode.unfocus();
                                              msgFocusNode.unfocus();
                                              setState(() {scroll = true;});
                                              sendInquiry(nameController.text.toString(), emailController.text.toString(),subController.text.toString(), msgController.text.toString());
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: IntrinsicHeight(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey[200],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset('assets/icons/sangh.png',),),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('sanghtexts'.tr, style: TextStyle(fontSize: 10,
                                              color: Colors.black,fontWeight: FontWeight.bold),),
                                          Text('gov_up'.tr, style: TextStyle(fontSize: 8,
                                              color: Colors.black,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0,10, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.home,color: Colors.grey,size: 20,),
                                  SizedBox(width: 5,),
                                  Container(width:MediaQuery.of(context).size.width*0.8,child: Text('fulladdress'.tr, style: TextStyle(fontSize: 10, color: Colors.black,fontWeight: FontWeight.w400),textAlign: TextAlign.left,)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0,10, 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.contact_page,color: Colors.grey,size: 20,),
                                  SizedBox(width: 5,),
                                  Text('0522-2975120, 2975121, 2975122', style: TextStyle(fontSize: 10, color: Colors.black,fontWeight: FontWeight.w400),textAlign: TextAlign.left,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                Positioned(
                  top:  MediaQuery.of(context).size.height/36,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Center(child:Image.network('https://cdn-icons-png.flaticon.com/512/3628/3628209.png',))
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigation(),
        floatingActionButton: isKeyboardVisible ? SizedBox() : appbarFloatingButton(),
        floatingActionButtonLocation: isKeyboardVisible ? null : FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future<void> sendInquiry(String name, String email,String subject, String message) async {
    var headers = {
      'access_key': 'PMAT-01H8Y3VD084HCJQC55544V2D2H',
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };
    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().sendEnquiryURL));
    request.fields.addAll({
      'name': name,
      'email': email,
      'subject': subject,
      'message': message
    });

    request.headers.addAll(headers);

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast('sendInquiryMsg'.tr);

        setState(() {scroll = false;});

        nameController.clear();
        emailController.clear();
        subController.clear();
        msgController.clear();

        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);

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
