


import 'dart:convert';
import 'dart:io';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/primaryActions.dart';
import 'package:yuvasathi/Utilles/toasts.dart';
import 'package:yuvasathi/loginPage.dart';
import 'package:yuvasathi/previousHomePage.dart';
import 'package:yuvasathi/userProfileEdit.dart';

import 'Utilles/action.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/appbarFloatingButton.dart';
import 'Utilles/bottomNavigation.dart';
import 'Utilles/url.dart';
import 'editPassword.dart';
import 'editProfile.dart';

class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {

  String userName  = "XXXXXXXXXX";
  String userEmail = "XXXXXXXXXX";
  String userPhone  = "XXXXXXXXXX";
  String gender  = "XXXXXXXXXX";
  String dob = "XXXXXXXXXX";
  String caste  = "XXXXXXXXXX";
  String typrofarea = "XXXXXXXXXX";
  String state  = "XXXXXXXXXX";
  String district  = "XXXXXXXXXX";
  String service = "XXXXXXXXXX";
  String empstatus  = "XXXXXXXXXX";
  String lastqualification = "XXXXXXXXXX";
  int? userId;
  String userImg ='';
  bool engLanguage = true;

  var genderITM = ['male'.tr,'female'.tr,'other'.tr,];
  var residenceITM = ['arban'.tr, 'rural'.tr,'rl&rbn'.tr,];
  var empStatusITM = ['status1'.tr, 'status2'.tr,'status3'.tr,'status4'.tr, 'status5'.tr,];

  bool uScroll=false;
  File? galleryFile;
  final picker = ImagePicker();
  String _version = 'Loading...';

  late String genderId;
  late String casteId ;
  late String typrofareaId;
  late String stateId ;
  late String districtId ;
  late String serviceId ;
  late String empstatusId;
  late String lastqualificationId;

  @override
  void initState() {
    getAllCategory();
    _getVersion();
    super.initState();
  }

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  Future getAllCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userID');
    userName = prefs.getString('userName')!;
    userPhone = prefs.getString('userPhone')!;
    engLanguage = prefs.getBool('engLanguage')!;
    //userEmail = prefs.getString('userEmail')!;
    //userDistrict = prefs.getString('userDistrict')!;
    // userAddress = prefs.getString('userAddress')!;
    //String? checkFile = prefs.getString('fileKey');
    //galleryFile = await getFileFromSharedPreferences();
    setState(() {});
    getUserData();
  }

  void _editProfile() async {
     await showDialog(context: context, builder: (BuildContext context) {
      return editProfile(userName,userPhone,userEmail,dob,genderId,casteId,serviceId,empstatusId,lastqualificationId,stateId,districtId,typrofareaId,);
    },);
  }

  void _editPassword() async {
    await showDialog(context: context, builder: (BuildContext context) {
      return editPassword(intToBase64(userId!));
    },);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 20.0,
          shadowColor: Colors.transparent,
          backgroundColor: appcolors.primaryColor,
          iconTheme: IconThemeData(color:appcolors.whiteColor),
          title: Image.asset('assets/icons/yuvalogo.png',width: 150,height: 50,fit:BoxFit.fill,color: Colors.white,),
          actions: [primaryActions(),],
        ),
        body: uScroll ? Center(child: CircularProgressIndicator(strokeWidth: 3,)) : SingleChildScrollView(
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
                        padding: EdgeInsets.all(20),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 100,),

                            getRow("username".tr,"$userName",Icons.person),
                            divider(),

                            getRow("contactno".tr,"$userPhone",Icons.phone_android),
                            divider(),

                            getRow("useremail".tr,"$userEmail",Icons.email),
                            divider(),

                            getRow("gender".tr,"$gender",Icons.email),
                            divider(),

                            getRow("dob".tr,"$dob",Icons.email),
                            divider(),

                            getRow("caste".tr,"$caste",Icons.email),
                            divider(),

                            getRow("typrofarea".tr,"$typrofarea",Icons.email),
                            divider(),

                            getRow("state".tr,"$state",Icons.email),
                            divider(),

                            getRow("district".tr,"$district",Icons.location_on),
                            divider(),

                            getRow("service".tr,"$service",Icons.location_on),
                            divider(),

                            getRow("empstatus".tr,"$empstatus",Icons.location_on),
                            divider(),

                            getRow("lastqualification".tr,"$lastqualification",Icons.location_on),
                            divider(),

                            SizedBox(height: 20,),

                            Container(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                          width: MediaQuery.of(context).size.width/2.5,
                                          height: 40,
                                          color: Colors.green,
                                            child: Center(
                                                child: Text('editprofile'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),),
                                            ),
                                        ),
                                      ),
                                    //onTap:  _editProfile
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => userProfileEdit(userName,userPhone,userEmail,dob,genderId,casteId,serviceId,empstatusId,lastqualificationId,stateId,districtId,typrofareaId)));
                                    },
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                            width: MediaQuery.of(context).size.width/2.5,
                                            height: 40,
                                            color: Colors.orange,
                                            child: Center(
                                                child: Text('changePassword'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),),
                                            ),
                                        ),
                                      ),
                                      onTap: _editPassword
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: InkWell(
                                child: Container(
                                   height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: appcolors.primaryColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(child: Text('logout'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: appcolors.primaryColor)))),
                                onTap: () async {
                                  _showLogoutDialog(context);
                                },
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text('App Version : $_version',style: TextStyle(fontSize: 12,color: Colors.grey,)),
                            SizedBox(height: 20,)
                          ],
                        ),
                      ),
                    ),
                ),
                Positioned(
                  top:  MediaQuery.of(context).size.height/36,
                  child: Column(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: appcolors.whiteColor,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: userImg == null || userImg==''
                                    ?  Center(child:ClipRect(child: Image.network('https://cdn-icons-png.flaticon.com/512/219/219983.png',)))
                                    : ClipOval(child: Image.network('${urls().base_url + userImg}',fit: BoxFit.cover,height: 100,width: 100,),),
                              ),
                              Positioned(
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          _showPicker(context: context);
                        },
                      ),
                      SizedBox(width: 5,),
                      Container(padding: EdgeInsets.all(5),width:MediaQuery.of(context).size.width*0.8,child: Text('$userName',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center,)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigation(),
        floatingActionButton: appbarFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget getRow(String name,String value,var icon) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(

            width: MediaQuery.of(context).size.width*.3,
            child: Text('$name :',style: const TextStyle(fontSize: 10,color:appcolors.blackColor)),
          ),
          Container(
              width: MediaQuery.of(context).size.width*.5,
              child: Text(value,style: const TextStyle(fontSize: 10,color:appcolors.blackColor,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2,)
          ),

        ],
      ),
    );
  }

  Widget divider(){
    return Container(
      padding:EdgeInsets.only(left: 8,right: 8),
      child: IntrinsicHeight(
        child: Divider(
          thickness: 1,
          color: Colors.grey[200],
        ),
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

  void _showPicker({required BuildContext context,}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource img,) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    if (xfilePick != null) {
      galleryFile = File(pickedFile!.path);

      await uploadPicToAPI(galleryFile!);
      //await saveFileToSharedPreferences(galleryFile!);

    } else {
      toasts().redToast('Nothing is selected');
    }
  }

  Future<void> uploadPicToAPI(File file) async {
    setState(() {uScroll = true;});
    String path=file.path;
    var headers = {
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };

    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().updateProfilePicURL));
    request.fields.addAll({
      'youth_id': intToBase64(userId!),
    });
    request.files.add(await http.MultipartFile.fromPath('file',path));

    request.headers.addAll(headers);

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast(results['msg']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => userProfile()), (Route<dynamic> route) => false);
      }else{
        if(results['code']==300){
          setState(() {uScroll = false;});
          toasts().redToast(results['msg']);
        }else{
          setState(() {uScroll = false;});
          toasts().redToast('Please Try Again');
        }
      }
    }
    else {
      setState(() {uScroll = false;});
      toasts().redToast('Server Error');
    }
  }

/*  Future<void> saveFileToSharedPreferences(File file) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String encodedFile = base64Encode(await file.readAsBytes());
      prefs.setString('fileKey', encodedFile);
    } catch (e) {
      print('Error saving file to SharedPreferences: $e');
    }
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
  }*/

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
        print('ggggg-----$getitems');
        setState(() {
          userName = getitems['name'] != null ? getitems['name'] : userName;
          userPhone = getitems['mobile'] != null ? getitems['mobile'] : userPhone;
          userEmail = getitems['email'] != null ? getitems['email'] : userEmail;
          gender = getitems['gender'] != null ? getitems['gender']=='M' ? genderITM[0] : getitems['gender']=='F' ? genderITM[1] : genderITM[2] : gender;
          dob = getitems['dob'] != null ? formatDateTime(getitems['dob']) : dob;
          caste = getitems['caste_title_eng'] != null ? engLanguage ? getitems['caste_title_eng'] : getitems['caste_title_hindi'] : caste;
          typrofarea = getitems['location_type']=='1' ? residenceITM[0] : getitems['location_type']=='2' ? residenceITM[1] : getitems['location_type']=='3' ? residenceITM[2] : typrofarea;
          state = getitems['state_eng_name'] != null ? engLanguage ? getitems['state_eng_name'] : getitems['state_hindi_name'] : state;
          district = getitems['district_title_eng'] != null ? engLanguage ? getitems['district_title_eng'] : getitems['district_title_hindi'] : district;
          service = getitems['service_title_eng'] != null ? engLanguage ? getitems['service_title_eng'] : getitems['service_title_hindi'] : service;
          empstatus = getitems['employment_status']=='1' ? empStatusITM[0] : getitems['employment_status']=='2' ? empStatusITM[1] : getitems['employment_status']=='3' ? empStatusITM[2] : getitems['employment_status']=='4' ? empStatusITM[3] : getitems['employment_status']=='5' ? empStatusITM[4] : empstatus;
          lastqualification = getitems['education_title_eng'] != null ? engLanguage ? getitems['education_title_eng'] : getitems['education_title_hindi'] : lastqualification;
          userImg = getitems['profile_pic'] != null ? getitems['profile_pic'] : userImg;

         /* genderId= '1';//getitems['gender'];
          casteId='1';//'${getitems['caste']}';
          typrofareaId='1';//'${getitems['location_type']}';
          stateId= '1';//'${getitems['state']}';
          districtId= '3';//'${getitems['district']}';
          serviceId='1';//'${getitems['services']}';
          empstatusId= '1';//'${getitems['employment_status']}';
          lastqualificationId='2';//'${getitems['last_qualification']}';*/

          genderId= getitems['gender']=='M' ? '1' : getitems['gender']=='F' ? '2' : '3';
          casteId=getitems['caste']==null ? '1' : '${getitems['caste']}';
          typrofareaId=getitems['location_type']==null ? '1' : '${getitems['location_type']}';
          stateId= getitems['state']==null ? '1' : '${getitems['state']}';
          districtId= getitems['district']==null ? '3' : '${getitems['district']}';
          serviceId=getitems['services']==null ? '1' : '${getitems['services']}';
          empstatusId= getitems['employment_status']==null ? '1' : '${getitems['employment_status']}';
          lastqualificationId=getitems['last_qualification']==null ? '2' : '${getitems['last_qualification']}';
          print('llllll-----${genderId}');
          uScroll = false;
        });
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

  String formatDateTime(String inputDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('dd-MM-yyyy');
    final date = inputFormat.parse(inputDate);
    return outputFormat.format(date);
  }

}

