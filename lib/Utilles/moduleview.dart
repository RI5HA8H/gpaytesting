

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/url.dart';

class moduleview  extends StatelessWidget {
  const moduleview ({Key? key,
    required this.count,
    required this.title,
    required this.path,
  }) : super(key: key);
  

  final String count;
  final String path;
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/homeCardViewbackground.png',), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
          child: Container(
            padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Image.network(urls().base_url+path,height: 40,width: 40,),
                SizedBox(height: 8),
                Text(title, style: TextStyle(fontSize: 10, color:appcolors.blackColor,fontWeight: FontWeight.bold),),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(0),
                      ),
                      child: Container(
                        width: 75,
                        height: 20,
                       // padding: EdgeInsets.all(2),
                        color: Colors.green[100],
                        child: Center(child: Text('$count'+' '+'scheme'.tr, style: TextStyle(fontSize: 10, color:appcolors.blackColor,),)),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(5),
                      ),
                      child: Container(
                        width: 20,
                        height: 20,
                        //padding: EdgeInsets.all(2),
                        color: Colors.green,
                        child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 10,),
                      ),
                    )
                  ],
                ),

              ],
            ),
          )
        ),
        Positioned(
          child: Container(),
        )
      ],
    );
  }
}
