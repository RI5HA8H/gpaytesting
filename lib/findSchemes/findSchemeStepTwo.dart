
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import '../Utilles/footer.dart';
import '../Utilles/helplineCardView.dart';
import '../Utilles/toasts.dart';
import '../homePage.dart';
import '../previousHomePage.dart';
import 'findSchemeStepOne.dart';
import 'findSchemeStepSeaven.dart';
import 'findSchemeStepThree.dart';


class findSchemeStepTwo extends StatefulWidget {
  const findSchemeStepTwo({Key? key}) : super(key: key);

  @override
  State<findSchemeStepTwo> createState() => _findSchemeStepTwoState();
}

class _findSchemeStepTwoState extends State<findSchemeStepTwo> {

  bool scroll = false;
  var selectedValue ;
  var agedropdownvalue;
  var ageitems = [18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,38,40,41,42,43,44,45];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => previousHomePage()), (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leadingWidth: 10,
          title: IntrinsicHeight(
            child: Row(
              children: [
                Image.asset('assets/icons/yuvalogo.png',width: 120,height: 50,fit:BoxFit.fill),
                VerticalDivider(color: Colors.grey,thickness: 1),
                Image.asset('assets/icons/dept_name_hindi.png',width: 120,height: 40,fit:BoxFit.fill),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color:appcolors.blackColor),
        ),
        body: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: Container(padding: EdgeInsets.only(left: 5,right: 5),child: Text('appbarSecondTitle'.tr,style: TextStyle(fontSize: 9,color: Colors.white),textAlign: TextAlign.center,maxLines: 3,))),
              backgroundColor: Color(0xff7959AC),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.purple[50],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   /* Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: InkWell(
                          child: Container(
                            width: 100,
                            height: 30,
                            color: Colors.grey[300],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back),
                                SizedBox(width: 5,),
                                Text('backButton'.tr),
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepOne()));
                          },
                        ),
                      ),
                    ),*/
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20,20, 0),
                      child: Text('step2'.tr, style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,),),
                    ),
                    Padding(
                      padding:EdgeInsets.fromLTRB(20, 0,20, 0),
                      child: Divider(color: Colors.black,),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10,20, 0),
                      child: Text('step2heading'.tr, style: TextStyle(fontSize: 18, color: Color(0xff7959AC),fontWeight: FontWeight.bold,),),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20,10,20, 10),
                      child: Text('step2subheading'.tr, style: TextStyle(fontSize: 12, color: Colors.grey),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child:  Center(child: Image.asset('assets/images/rbb2.png',fit: BoxFit.fill,width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/2,)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25,10,20, 0),
                      child: Text('gender'.tr, style: TextStyle(fontSize: 12, color: Colors.black),),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10,20, 10),
                      child: GroupButton(
                        isRadio: true,
                        onSelected: (val, i, selected) {
                          selectedValue=i+1;
                        },
                        buttons: ['male'.tr,'female'.tr,'other'.tr,],
                        options: GroupButtonOptions(
                            buttonWidth:80,
                            buttonHeight: 40,
                              runSpacing: 10,
                              unselectedColor: Colors.white,
                              selectedColor: Colors.green,
                              /*unselectedShadow: [
                                BoxShadow(
                                  color: Color(0xffC5C5C5).withOpacity(0.5), // Shadow color
                                  spreadRadius: 2,                     // Spread radius
                                  blurRadius: 5,                       // Blur radius
                                  offset: Offset(0, 3),                // Offset in the Y direction
                                ),
                              ],*/
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              unselectedBorderColor:  Color(0xffC5C5C5),
                              selectedBorderColor: Colors.green,
                              selectedTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                              unselectedTextStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black)

                      ),
                    ),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25,10,20, 0),
                      child: Text('age'.tr, style: TextStyle(fontSize: 12, color: Colors.black),),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10,20, 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text('age'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                          isExpanded: true,
                          iconStyleData: IconStyleData(
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(Icons.keyboard_arrow_down),
                              )
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: MediaQuery.of(context).size.height/2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                          items: ageitems.map((item) {
                            return DropdownMenuItem(
                              value: item.toString(),
                              child: Text(item.toString()+'  '+'year'.tr,style: TextStyle(fontSize: 12,color: Color(0xff707070)),),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              agedropdownvalue = newVal;
                            });
                          },
                          value: agedropdownvalue,
                        ),
                      ),
                    ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 30,20, 10),
                          child: ElevatedButton(
                            child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('next'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)))),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xff7959AC)),
                            ),
                            onPressed: (){
                              if(agedropdownvalue==null || selectedValue==null){
                                toasts().redToast('warningtoast'.tr);
                              }else{
                                toasts().greenToast('rightsteptoast'.tr);
                                setState(() {});
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepThree(agedropdownvalue,selectedValue)));
                              }
                            },
                          ),
                        ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:helplineCardView(),
                    ),
                    footer(),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
