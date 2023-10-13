

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/url.dart';

class ratingFilter extends StatefulWidget {
  const ratingFilter({Key? key}) : super(key: key);

  @override
  State<ratingFilter> createState() => _ratingFilterState();
}

class _ratingFilterState extends State<ratingFilter> {

  var ratingdropdownvalue;
  var ratingname;
  String url=urls().base_url;

    final List<DropdownItem> items = [
    DropdownItem(id:1,name: '1 Star',isSelected:false),
    DropdownItem(id:2,name: '2 Star',isSelected:false),
    DropdownItem(id:3,name: '3 Star',isSelected:false),
    DropdownItem(id:4,name: '4 Star',isSelected:false),
    DropdownItem(id:5,name: '5 Star',isSelected:false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text('rating'.tr,style: TextStyle(fontSize: 10,color: Colors.black),),
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200],
            ),
          ),
          iconStyleData: IconStyleData(
            iconSize: 12,
              icon: Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Icon(Icons.keyboard_arrow_down_outlined,color:  Colors.black,),
              )
          ),
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5),),
            ),
          ),
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((item) {
              return Row(
                children: [
                  Center(child: Text('rating'.tr,style: TextStyle(fontSize: 10,color: Colors.black),),),
                ],
              );
            }).toList();
          },
          items:items.map((item) {
            return DropdownMenuItem<DropdownItem>(
              value: item,
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Checkbox(
                      value: item.isSelected,
                      onChanged: (bool? value) {
                        if(value!=null){
                          setState(() {
                            item.isSelected = value;
                          });
                        }
                      },),
                    Text(item.name,style: TextStyle(fontSize: 10,color: Colors.black),),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              ratingdropdownvalue = newVal;
              print('vvvvvvvvvvvvvvvvv-------${ratingdropdownvalue.isSelected}');
            });
          },
          value: ratingdropdownvalue,
        ),
      ),
    );
  }
}
class DropdownItem {
  final int id;
  final String name;
  bool isSelected;
  DropdownItem({required this.id,required this.name,required this.isSelected});
}
