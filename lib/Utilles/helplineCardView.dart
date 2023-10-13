


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class helplineCardView extends StatefulWidget {
  const helplineCardView({Key? key}) : super(key: key);

  @override
  State<helplineCardView> createState() => _helplineCardViewState();
}

class _helplineCardViewState extends State<helplineCardView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child:  Center(child: Image.asset('assets/images/footercard.png',width: 200,height: 200,)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20,0,20, 0),
            child: Text('helpLineHeading'.tr, style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold,),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20,20, 20),
            child: ElevatedButton(
              child: SizedBox(width: double.infinity,child: Container(padding:EdgeInsets.fromLTRB(5, 15, 5, 15),child: Center(child: Text('helpLineSubHeading'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),)))),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff008180)),
              ),
              onPressed: () async {
                final call = Uri.parse('tel:+91 9005604448');
                if (await canLaunchUrl(call)) {
                launchUrl(call);
                } else {
                throw 'Could not launch $call';
                }
              },
            ),
          ) ,
        ],
      ),
    );
  }
}
