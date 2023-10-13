
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Utilles/toasts.dart';
import 'package:yuvasathi/Utilles/url.dart';
import 'package:yuvasathi/previousHomePage.dart';
import 'package:yuvasathi/registrationPage.dart';
import 'package:http/http.dart' as http;
import '../loginPage.dart';
import 'allAPI.dart';

class primaryActions extends StatefulWidget {
  const primaryActions({Key? key}) : super(key: key);

  @override
  State<primaryActions> createState() => _primaryActionsState();
}

class _primaryActionsState extends State<primaryActions> {

  int? userId = 0;
  String userName = "XXXXXX";
  String userEmail = "XXXXXX";
  String userPhone ="XXXXXX";
  String userDistrict = "XXXXXX";
  String userAddress ="XXXXXX";

  File? galleryFile;
  bool uScroll=false;
  String userImg='';

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  Future getAllCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId =prefs.getInt('userID');
    userName = prefs.getString('userName')!;
    userPhone = prefs.getString('userPhone')!;
    userImg = prefs.getString('userImg')!;
    if(userId!=0 && userId!=null){
      getUserData();
    }
    //galleryFile = await getFileFromSharedPreferences();
    setState(() {});

  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      child: userId == 0 || userId == null
          ? Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)
                    ),
                    child: InkWell(
                      child: Container(
                        width: 80,
                        height: 27,
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        color: Colors.green,
                        child: Center(child: Text('register'.tr,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => registrationPage()));
                      },
                    ),
                  ),
                  SizedBox(width: 5,),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)
                    ),
                    child: InkWell(
                      child: Container(
                        width: 70,
                        height: 27,
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        color: Colors.orange,
                        child: Center(child: Text('loginSmall'.tr,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
             )
          : GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                child:  userImg == null || userImg==''
                    ?  Center(child:ClipRect(child: Image.network('https://cdn-icons-png.flaticon.com/512/219/219983.png',)))
                    : ClipOval(child: Image.network('${urls().base_url + userImg}',fit: BoxFit.cover,height: 100,width: 100,),),
              ),
            ),
            SizedBox(width: 5,),
            Container(width:MediaQuery.of(context).size.width/6,child: Text('$userName',style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w400),softWrap: true,maxLines: 1,overflow: TextOverflow.ellipsis,)),
            Icon(Icons.keyboard_arrow_down_sharp),
            SizedBox(width: 10,),
          ],
        ),
        onTap: () {
          _showLogoutDialog(context);
        },
      )
      ,
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
                prefs.setString('userImg', '');
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);
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


  Future<void> getUserData() async {
    setState(() {uScroll = true;});
    String encodedId=intToBase64(userId!);
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().youthProfileURL+'?youth_id='+encodedId));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userName = getitems['name'] != null ? getitems['name'] : userName;
          userImg = getitems['profile_pic'] != null ? getitems['profile_pic'] : userImg;

          prefs.setInt('userID', getitems['id']);
          prefs.setString('userName', getitems['name']);
          prefs.setString('userPhone',getitems['mobile']);
          prefs.setString('userImg',getitems['profile_pic']);
          uScroll = false;
        });
        //something
      } else {
        toasts().redToast('Please Try Again');
        setState(() {
          uScroll = false;
        });
      }
    } else {
      toasts().redToast('Server Error');
      setState(() {
        uScroll = false;
      });
    }
  }

  String intToBase64(int value) {
    final encoded = base64Encode(utf8.encode(value.toString()));
    return encoded;
  }
}
