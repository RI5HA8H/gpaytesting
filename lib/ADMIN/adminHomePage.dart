
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/ADMIN/adninUtilles/adminActions.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import '../Utilles/allAPI.dart';
import '../Utilles/toasts.dart';
import '../Utilles/url.dart';
import '../previousHomePage.dart';
import 'adminEnquiriesList.dart';
import 'adminRequestList.dart';
import 'adminSchemeList.dart';
import 'adminYouthList.dart';
import 'adninUtilles/adminModule.dart';

class adminHomePage extends StatefulWidget {
  const adminHomePage({Key? key}) : super(key: key);

  @override
  State<adminHomePage> createState() => _adminHomePageState();
}

class _adminHomePageState extends State<adminHomePage> {

  bool scroll=false;
  int totalYouth=0;
  int totalStudentYouth=0;
  int totalEntrepreneursYouth=0;
  int nonVerifyUser=0;
  int verifyUser=0;
  int complete_profile=0;
  int totalSchemes=0;
  int totalSchemesStudent=0;
  int totalStateSchemes=0;
  int totalCentralSchemes=0;
  int totalCentrallySchemes=0;
  int totalStartUp=0;
  int totalRequests=0;
  int totalEnquiries=0;
  int totalAppliedYouth=0;

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        _showLogoutDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor:appcolors.primaryColor,
          leadingWidth: 20.0,
          iconTheme: IconThemeData(color:appcolors.whiteColor),
          title: Image.asset('assets/icons/yuvasathi_purewhite.png',width: 120,height: 40,fit:BoxFit.fill),
          actions: [adminActions()],
        ),
        body: scroll ? Center(child: CircularProgressIndicator(strokeWidth: 3,color: appcolors.adminPrimaryColor,)) : SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2,color: appcolors.adminPrimaryColor),
                      borderRadius: BorderRadius.circular(0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text('YOUTH Applicant Registration :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                      ),
                      Divider(
                        thickness: 1,
                        color: appcolors.adminPrimaryColor,
                      ),
                      Container(
                        height: 500,
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: GridView(
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 150,
                          ),
                          children: [
                            InkWell(
                                child: adminModule(title: 'Total Registerd Youth', path: 'assets/icons/ay1.png',count: '$totalYouth',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminYouthList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Non Verified Youth', path: 'assets/icons/ay2.png',count: '$nonVerifyUser',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminYouthList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Verified Youth', path: 'assets/icons/ay3.png',count: '$verifyUser',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminYouthList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Student Registered', path: 'assets/icons/ay4.png',count: '$totalStudentYouth',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminYouthList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Complete Profile Youth', path: 'assets/icons/ay5.png',count: '$complete_profile',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminYouthList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Entrepreneurs', path: 'assets/icons/ay6.png',count: '$totalEntrepreneursYouth',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminYouthList()));
                              },
                            ),
                           // adminModule(title: 'Total Click On Applied Scheme By Youth For All Scheme', path: 'assets/icons/ab_person.png',count: '8310',),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2,color: appcolors.adminPrimaryColor),
                      borderRadius: BorderRadius.circular(0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Schemes Listing :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                      ),
                      Divider(
                        thickness: 1,
                        color: appcolors.adminPrimaryColor,
                      ),
                      Container(
                        height: 500,
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: GridView(
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 150,
                          ),
                          children: [
                            InkWell(
                                child: adminModule(title: 'Total Schemes Listed', path: 'assets/icons/as1.png',count: '$totalSchemes',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminSchemeList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total State level Schemes', path: 'assets/icons/as2.png',count: '$totalStateSchemes',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminSchemeList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Central Gov Schemes', path: 'assets/icons/as3.png',count: '$totalCentralSchemes',),
                                onTap: (){
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminSchemeList()));
                                },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Cen. Sponsored Schemes', path: 'assets/icons/as4.png',count: '$totalCentrallySchemes',),
                               onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminSchemeList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Startup Reg. Schemes', path: 'assets/icons/as5.png',count: '$totalStartUp',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminSchemeList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Schemes for Students', path: 'assets/icons/as6.png',count: '$totalSchemesStudent',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminSchemeList()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2,color: appcolors.adminPrimaryColor),
                      borderRadius: BorderRadius.circular(0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Forums & Enquiry :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                      ),
                      Divider(
                        thickness: 1,
                        color: appcolors.adminPrimaryColor,
                      ),
                      Container(
                        height: 180,
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: GridView(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 150,
                          ),
                          children: [
                            InkWell(
                                child: adminModule(title: 'Total Requests for Topic', path: 'assets/icons/af1.png',count: '$totalRequests',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminRequestList()));
                              },
                            ),
                            InkWell(
                                child: adminModule(title: 'Total Enquiries', path: 'assets/icons/af2.png',count: '$totalEnquiries',),
                                onTap: (){
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => adminEnquiriesList()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('cancel'),
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
              child: Text('logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> getAllCategory() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().adminDashboardURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      toasts().greenToast('Data fetch Successfully');
      totalYouth=results['totalYouth'];
      totalStudentYouth=results['totalStudentYouth'];
      totalEntrepreneursYouth=results['totalEntrepreneursYouth'];
      nonVerifyUser=results['nonVerifyUser'];
      verifyUser=results['verifyUser'];
      complete_profile=results['complete_profile'];
      totalSchemes=results['totalSchemes'];
      totalSchemesStudent=results['totalSchemesStudent'];
      totalStateSchemes=results['totalStateSchemes'];
      totalCentralSchemes=results['totalCentralSchemes'];
      totalCentrallySchemes=results['totalCentrallySchemes'];
      totalStartUp=results['totalStartUp'];
      totalRequests=results['totalRequests'];
      totalEnquiries=results['totalEnquiries'];
      totalAppliedYouth=results['totalAppliedYouth'];

      setState(() {scroll = false;});
    } else {
      toasts().redToast('Server Error');
      setState(() {scroll = false;});
    }
  }
}
