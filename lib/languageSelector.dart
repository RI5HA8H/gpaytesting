

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/previousHomePage.dart';

import 'Utilles/toasts.dart';
import 'loginPage.dart';

class languageSelector extends StatefulWidget {
  const languageSelector({Key? key}) : super(key: key);

  @override
  State<languageSelector> createState() => _languageSelectorState();
}

class _languageSelectorState extends State<languageSelector> {

  bool scroll = false;
  var selectedValue ;
  String _version = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Center(
                  child: Image.asset('assets/icons/yuvalogo.png',height: 100,width: 250,),
                ),
                SizedBox(height: 20,),
                Text('Select Language', style: TextStyle(fontSize: 24, color: Colors.orange,fontWeight: FontWeight.bold,),),
                Text('भाषा का चयन करें', style: TextStyle(fontSize: 20, color:Colors.orange,fontWeight: FontWeight.bold,),),
                SizedBox(height: 50,),
                GroupButton(
                  isRadio: true,
                  onSelected: (val, i, selected) async {
                    selectedValue=val;
                    if(selectedValue=='English'){
                    toasts().greenToast('Thank You for selecting English Language');
                    Get.updateLocale(Locale('en', 'US'));
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('engLanguage', true);
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);
                    });
                    }else{
                    toasts().greenToast('हिंदी भाषा का चयन करने के लिए धन्यवाद');
                    Get.updateLocale(Locale('hi', 'IN'));
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('engLanguage', false);
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);
                    });
                  }},
                  buttons: ["English", "हिंदी",],
                  options: GroupButtonOptions(
                      runSpacing: 10,
                      buttonWidth:double.infinity,
                      buttonHeight: 50,
                      unselectedColor: Colors.white,
                      selectedColor: Colors.green,
                      unselectedShadow: [
                        BoxShadow(
                          color: Color(0xffC5C5C5).withOpacity(0.5), // Shadow color
                          spreadRadius: 2,                     // Spread radius
                          blurRadius: 5,                       // Blur radius
                          offset: Offset(0, 3),                // Offset in the Y direction
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(5),),
                      unselectedBorderColor:  Colors.grey[200],
                      selectedBorderColor: Colors.green,
                      selectedTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)
                  ),
                ),
                SizedBox(height: 50,),
               /* ElevatedButton(
                  child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('शुरू करें / Start Now',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)))),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                  onPressed: () async {
                    if(selectedValue==null){
                      toasts().redToast('सबसे पहले भाषा का चयन करें \n First of all Select Language');
                    }else{
                      if(selectedValue=='English'){
                      toasts().greenToast('Thank You for selecting English Language');
                      Get.updateLocale(Locale('en', 'US'));
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('engLanguage', true);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                      }else{
                        toasts().greenToast('हिंदी भाषा का चयन करने के लिए धन्यवाद');
                        Get.updateLocale(Locale('hi', 'IN'));
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setBool('engLanguage', false);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                      }

                    }
                  },
                ),*/
                Text('App Version : $_version',style: TextStyle(fontSize: 12,color: Colors.grey,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
