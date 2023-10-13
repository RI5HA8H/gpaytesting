

import 'package:flutter/material.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';

class complexModuleView extends StatelessWidget {
  const complexModuleView ({Key? key,
    required this.title,
    required this.path,
  }) : super(key: key);


  final String path;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 200,
            width: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/curvecardbackground.png'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(path,height: 50,width: 50,),
                  SizedBox(height: 10),
                  Text(title, style: TextStyle(fontSize: 12, color:appcolors.blackColor,fontWeight: FontWeight.bold),),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(bottom: 5,right: 15),
              height:  25,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bottomCardview.png'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            child: Center(child: Text('VIEW',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}
