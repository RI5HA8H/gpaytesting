

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/findSchemes/findSchemeStepTwo.dart';
import 'package:yuvasathi/homePage.dart';
import 'package:yuvasathi/loginPage.dart';
import 'package:yuvasathi/userProfile.dart';

import '../Schemes/schemList.dart';
import '../callSupport.dart';
import '../findSchemes/findSchemeStepOne.dart';


class bottomNavigation extends StatefulWidget {
  const bottomNavigation({Key? key}) : super(key: key);

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {


  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  AnimatedBottomNavigationBar.builder(
      itemCount: items.length,
      tabBuilder: (int index, bool isActive) {
        //print('iiiiiiii---$index');
        final item = items[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item.iconPath,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            SizedBox(height: 5), // Adjust spacing
            Text(
              item.title,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color:Colors.white,
              ),
            ),
          ],
        );
      },



      splashColor: Colors.transparent,
      splashSpeedInMilliseconds: 0,
      elevation: 0,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 16,
      rightCornerRadius: 16,
          backgroundColor: Color(0xff553A5A),
          activeIndex: _bottomNavIndex,
          onTap: (index) {
            setState(() async {
              _bottomNavIndex = index;
              if(_bottomNavIndex==0){
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? userId =prefs.getInt('userID');
                if(userId==0 || userId==null){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepOne()));
                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepTwo()));
                }
              }
              if(_bottomNavIndex==1){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => callSupport()));
              }
              if(_bottomNavIndex==2){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => homePage()));
              }
              if(_bottomNavIndex==3){
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? userId =prefs.getInt('userID');
                if(userId==0 || userId==null){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => userProfile()));
                }
              }
            });
          },
    );
  }

}
class BottomNavigationBarItemModel {
  final String iconPath;
  final String title;

  BottomNavigationBarItemModel({
    required this.iconPath,
    required this.title,
  });
}

final List<BottomNavigationBarItemModel> items = [
  BottomNavigationBarItemModel(
    iconPath: 'assets/icons/ab_search.png',
    title: 'Scheme Search',
  ),
  BottomNavigationBarItemModel(
    iconPath: 'assets/icons/ab_calls.png',
    title: 'Call Support',
  ),
  BottomNavigationBarItemModel(
    iconPath: 'assets/icons/ab_scheam.png',
    title: 'Govt. Schemes',
  ),
  BottomNavigationBarItemModel(
    iconPath: 'assets/icons/ab_person.png',
    title: 'Profile',
  ),
];
