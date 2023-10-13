


import 'package:flutter/material.dart';

class editTextWithoutShadow extends StatelessWidget {
   editTextWithoutShadow({Key? key,
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
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
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
