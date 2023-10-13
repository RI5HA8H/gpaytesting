


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class footer extends StatefulWidget {
  const footer({Key? key}) : super(key: key);

  @override
  State<footer> createState() => _footerState();
}

class _footerState extends State<footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff011021),
      width: double.infinity,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/yuvalogo.png',width: 80,height: 40,color: Colors.white,),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0,20, 5),
            child: Text('footerHeading'.tr, style: TextStyle(fontSize: 8, color: Colors.grey),textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}
