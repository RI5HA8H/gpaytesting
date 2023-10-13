

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/ADMIN/adminLogin.dart';
import 'package:yuvasathi/previousHomePage.dart';

class adminActions extends StatefulWidget {
  const adminActions({Key? key}) : super(key: key);

  @override
  State<adminActions> createState() => _adminActionsState();
}

class _adminActionsState extends State<adminActions> {

  int adminUserID = 0;
  String adminUserName = "XXXXXX";
  String adminUserEmail ="XXXXXX";
  String adminUserPhone = "XXXXXX";
  String adminUserEmpID ="XXXXXX";
  String adminUserRole ="XXXXXX";

  File? galleryFile;

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  Future getAllCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    adminUserName = prefs.getString('adminUserName')!;
    adminUserEmail = prefs.getString('adminUserEmail')!;

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width/2,
      child: IconButton(
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child:  galleryFile == null
                    ?  Center(child:ClipRect(child: Image.network('https://cdn-icons-png.flaticon.com/512/219/219983.png',)))
                    : ClipOval(child: Image.file(galleryFile!,fit: BoxFit.cover,height: 100,width: 100,),),
              ),
            ),
            SizedBox(width: 5,),
            Container(width:MediaQuery.of(context).size.width/5,child: Text(adminUserName,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w400,),softWrap: true,maxLines: 1,overflow: TextOverflow.ellipsis,)),
            Icon(Icons.keyboard_arrow_down_sharp,color: Colors.white,),
          ],
        ),
        color: Colors.white,
        onPressed: () {
          _showLogoutDialog(context);
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('logoutConfirm'.tr),
          content: Text('logoutConfirmTitle'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('adminUserID', 0);
                prefs.setString('adminUserName', 'XXXXXXXXXX');
                prefs.setString('adminUserEmail','XXXXXXXXXX');
                prefs.setString('adminUserPhone','XXXXXXXXXX');
                prefs.setString('adminUserEmpID','XXXXXXXXXX');
                prefs.setString('adminUserRole', 'XXXXXXXXXX');
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);
              },
              child: Text('logout'.tr),
            ),
          ],
        );
      },
    );
  }

}
