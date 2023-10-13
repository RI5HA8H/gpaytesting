

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuvasathi/Utilles/toasts.dart';

class searchCardView extends StatefulWidget {
  const searchCardView({Key? key}) : super(key: key);

  @override
  State<searchCardView> createState() => _searchCardViewState();
}

class _searchCardViewState extends State<searchCardView> {

  var schemedropdownvalue;
  var govrnmentdropdownvalue;
  var departmentdropdownvalue;
  var schemeitems = ['schemes1'.tr, 'schemes2'.tr, 'schemes3'.tr, 'schemes4'.tr, 'schemes5'.tr,'schemes6'.tr, 'schemes7'.tr, 'schemes8'.tr, 'schemes9'.tr, 'schemes10'.tr];
  var govrnmentitems = ['stateGov'.tr, 'centralGov'.tr, 'centralSpon'.tr,];
  var departmentitems = ['vibhag1'.tr, 'vibhag2'.tr, 'vibhag3'.tr,'vibhag4'.tr,];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('searchCardheading'.tr, style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500,),),
        SizedBox(height: 5,),
        Text('searchCardsubheading'.tr, style: TextStyle(fontSize: 12, color: Colors.grey),),
        SizedBox(height: 20,),
        Text('searchtexthead1'.tr, style: TextStyle(fontSize: 14, color: Colors.grey),),
        SizedBox(height: 5,),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text('searchtextsubhead1'.tr),
            isExpanded: true,
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[200],
              ),
            ),
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
            items: schemeitems.map((item) {
              return DropdownMenuItem(
                value: item.toString(),
                child: Text(item.toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                schemedropdownvalue = newVal;
              });
            },
            value: schemedropdownvalue,
          ),
        ),
        SizedBox(height: 10,),
        Text('searchtexthead2'.tr, style: TextStyle(fontSize: 14, color: Colors.grey),),
        SizedBox(height: 5,),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text('searchtextsubhead2'.tr),
            isExpanded: true,
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[200],
              ),
            ),
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
            items: govrnmentitems.map((item) {
              return DropdownMenuItem(
                value: item.toString(),
                child: Text(item.toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                govrnmentdropdownvalue = newVal;
              });
            },
            value: govrnmentdropdownvalue,
          ),
        ),
        SizedBox(height: 10,),
        Text('searchtexthead3'.tr, style: TextStyle(fontSize: 14, color: Colors.grey),),
        SizedBox(height: 5,),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text('searchtextsubhead3'.tr),
            isExpanded: true,
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[200],
              ),
            ),
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
            items: departmentitems.map((item) {
              return DropdownMenuItem(
                value: item.toString(),
                child: Text(item.toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                departmentdropdownvalue = newVal;
              });
            },
            value: departmentdropdownvalue,
          ),
        ),
        SizedBox(height: 20,),
        ElevatedButton(
          child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('search'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)))),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green[400]),
          ),
          onPressed: (){
            if(schemedropdownvalue==null || govrnmentdropdownvalue==null || departmentdropdownvalue==null){
              toasts().redToast('warningtoast'.tr);
            }else{
              toasts().greenToast('rightsteptoast'.tr);
              setState(() {
                // scroll=true;
              });
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepFour()));
            }
          },
        ),
        SizedBox(height: 15,),
      ],
    );
  }
}
