
import 'package:flutter/material.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'adninUtilles/adminActions.dart';

class adminEnquiriesList extends StatefulWidget {
  const adminEnquiriesList({Key? key}) : super(key: key);

  @override
  State<adminEnquiriesList> createState() => _adminEnquiriesListState();
}

class _adminEnquiriesListState extends State<adminEnquiriesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor:appcolors.adminPrimaryColor,
        leadingWidth: 20.0,
        iconTheme: IconThemeData(color:appcolors.whiteColor),
        title: Image.asset('assets/icons/yuvasathi_purewhite.png',width: 120,height: 40,fit:BoxFit.fill),
        actions: [adminActions()],
      ),
      body: Container(

      ),
    );
  }
}
