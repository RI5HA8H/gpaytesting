
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class toasts{

  void redToast(String printvalue){
    Fluttertoast.showToast(
        msg: printvalue,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        textColor: Colors.white,
        fontSize: 14.0

    );
  }


  void greenToast(String printvalue){
    Fluttertoast.showToast(
        msg: printvalue,
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }


  void greyToast(String printvalue){
    Fluttertoast.showToast(
        msg: printvalue,
        backgroundColor: Colors.grey[300],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        textColor: Colors.black,
        fontSize: 14.0
    );
  }



}