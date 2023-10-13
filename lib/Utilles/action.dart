


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginPage.dart';

class action extends StatefulWidget {
  const action({Key? key}) : super(key: key);

  @override
  State<action> createState() => _actionState();
}

class _actionState extends State<action> {

  String userName = "XXXXXX";
  String userEmail = "XXXXXX";
  String userPhone ="XXXXXX";
  String userDistrict = "XXXXXX";
  String userAddress ="XXXXXX";

  File? galleryFile;


  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  Future getAllCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName')!;
    //userEmail = prefs.getString('userEmail')!;
    userPhone = prefs.getString('userPhone')!;
    //userDistrict = prefs.getString('userDistrict')!;
    // userAddress = prefs.getString('userAddress')!;
    galleryFile = await getFileFromSharedPreferences();
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
            Container(width:MediaQuery.of(context).size.width/6,child: Text('$userName',style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w400,),softWrap: true,maxLines: 1,overflow: TextOverflow.ellipsis,)),
            Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
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
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('userID', 0);
                prefs.setString('userName', 'XXXXXXXXXX');
                //prefs.setString('userEmail','XXXXXXXXXX']);
                prefs.setString('userPhone','XXXXXXXXXX');
                prefs.setString('userVerify','XXXXXXXXXX');
                prefs.setString('fileKey', 'XXXXXXXXXX');
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginPage()), (Route<dynamic> route) => false);
              },
              child: Text('logout'.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('cancel'.tr),
            ),
          ],
        );
      },
    );
  }


  Future<File?> getFileFromSharedPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? encodedFile = prefs.getString('fileKey');
      if (encodedFile != null && encodedFile!='') {
        List<int> bytes = base64Decode(encodedFile);
        final directory = await getTemporaryDirectory();
        final File file = File('${directory.path}/my_file.txt');
        await file.writeAsBytes(bytes);
        return file;
      }
    } catch (e) {
      print('Error retrieving file from SharedPreferences: $e');
    }
    return null;
  }
}
