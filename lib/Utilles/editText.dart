

import 'package:flutter/material.dart';


class editTextSimple extends StatelessWidget {
  editTextSimple({Key? key,
    required this.controllers,
    required this.focusNode,
    required this.keyboardTypes,
    required this.hint,
    required this.maxlength,
    this.counterTexts='',
    this.label='',
  }) : super(key: key);

  TextEditingController controllers;
  FocusNode focusNode = FocusNode();
  var keyboardTypes;
  String label;
  String hint;
  String counterTexts;
  int maxlength;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
        boxShadow: [
          BoxShadow(
            color: Color(0xffC5C5C5).withOpacity(0.5), // Shadow color
            spreadRadius: 2,                     // Spread radius
            blurRadius: 5,                       // Blur radius
            offset: Offset(0, 3),                // Offset in the Y direction
          ),
        ],
      ),
      child: TextField(
        maxLength: maxlength,
        keyboardType:keyboardTypes,
        controller: controllers,
        focusNode: focusNode,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Color(0xffC5C5C5), // Border color
                width: 0.5,         // Border width
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
             counterText: counterTexts,
             labelText: label,
            hintText: hint,
            hintStyle: TextStyle(fontSize: 12)
        ),
      ),
    );
  }
}




