


import 'package:flutter/material.dart';

class profileEditText extends StatelessWidget {
   profileEditText({Key? key,
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
    return  TextField(
      maxLength: maxlength,
      keyboardType:keyboardTypes,
      controller: controllers,
      focusNode: focusNode,
      style: TextStyle(fontSize: 12),
      decoration: InputDecoration(
          counterText: counterTexts,
          hintText: hint,
      ),
    );
  }
}
