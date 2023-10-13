
import 'package:flutter/material.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';

class adminModule extends StatelessWidget {
  const adminModule ({Key? key,
    required this.title,
    required this.path,
    required this.count,
  }) : super(key: key);


  final String path;
  final String title;
  final String count;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(width: 1,color: appcolors.adminPrimaryColor),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(path,height: 50,width: 50,),
            SizedBox(height: 5),
            Text(count+'+', style: TextStyle(fontSize: 16, color:Colors.black,fontWeight: FontWeight.bold),),
            Text(title, style: TextStyle(fontSize: 8, color:Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(height: 10),
            //Container(padding: EdgeInsets.only(top: 2,bottom: 2),color: Colors.green,child: Center(child: Text('VIEW',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white),)))
          ],
        ),
      ),
    );
  }
}
