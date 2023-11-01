
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Test Firebase',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, ),),
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Image.asset('assets/images/mHomePageSlider.jpg',fit: BoxFit.fill,),
            ),
            Container(
              height: 300,
              color:Colors.white,
              child: Center(
                child: Text("Please visit after some time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),)
              ),
            ),
            Container(
              height: 300,
              color:Colors.blue[50],

            ),
            Container(
              height: 20,
              color: Colors.black,
              child: Center(
                  child: Text("Copyright © 2023. All rights reserved.",style: TextStyle(fontSize: 12,color: Colors.white),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
