


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuvasathi/userProfile.dart';
import 'package:http/http.dart' as http;
import 'Utilles/allAPI.dart';
import 'Utilles/profileEditText.dart';
import 'Utilles/toasts.dart';
import 'Utilles/url.dart';

class editPassword extends StatefulWidget {
  var encUserId ;

  editPassword(this.encUserId,);

  @override
  State<editPassword> createState() => _editPasswordState(encUserId);
}

class _editPasswordState extends State<editPassword> {
  _editPasswordState(encUserId);

  bool scroll=false;
  TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode newPasswordNoFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("changePassword".tr,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        content: Container(
          height: 160,
          child: scroll  ? Center(child: CircularProgressIndicator(strokeWidth: 3,)) : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                profileEditText(
                  controllers: oldPasswordController,
                  focusNode: oldPasswordFocusNode,
                  hint: 'oldPassword'.tr,
                  keyboardTypes: TextInputType.text,
                  maxlength: 10,
                ),

                profileEditText(
                  controllers: newPasswordController,
                  focusNode: newPasswordNoFocusNode,
                  hint: 'newPassword'.tr,
                  keyboardTypes: TextInputType.text,
                  maxlength: 10,
                ),

                profileEditText(
                  controllers: confirmPasswordController,
                  focusNode: confirmFocusNode,
                  hint: 'confirmPassword'.tr,
                  keyboardTypes: TextInputType.text,
                  maxlength: 10,
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
            if (oldPasswordController.text.isEmpty == true || newPasswordController.text.isEmpty == true || confirmPasswordController.text.isEmpty == true) {
              toasts().redToast('warningtoast'.tr);
            } else {
              oldPasswordFocusNode.unfocus();
              newPasswordNoFocusNode.unfocus();
              confirmFocusNode.unfocus();
              updatePasswordAPI();
            }
          },
          child: Text("updatePassword".tr),
        ),
      ],
    );
  }

  void updatePasswordAPI() async {
    setState(() {scroll=true;});
    var headers = {
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };

    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().updatePasswordURL));
    request.fields.addAll({
      'youth_id': widget.encUserId,
      'old_password': oldPasswordController.text,
      'new_password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text
    });

    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast(results['msg']);
        setState(() {scroll = false;});
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => userProfile()), (Route<dynamic> route) => false);
      }else{
        if(results['code']==319){
          toasts().redToast(results['msg']);
          setState(() {scroll = false;});
          Navigator.pop(context);
        }else{
          toasts().redToast('Please Try Again');
          setState(() {scroll = false;});
          Navigator.pop(context);
        }
      }
    }
    else {
      toasts().redToast('Server Error');
      setState(() {scroll = false;});
      Navigator.pop(context);
    }
  }
}
