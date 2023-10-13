
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import '../Utilles/allAPI.dart';
import '../Utilles/editText.dart';
import '../Utilles/footer.dart';
import '../Utilles/helplineCardView.dart';
import '../Utilles/toasts.dart';
import '../Utilles/url.dart';
import '../homePage.dart';
import 'findSchemeStepFour.dart';
import 'findSchemeStepSeaven.dart';
import 'findSchemeStepSix.dart';


class findSchemeStepFive extends StatefulWidget {
  var ageValue;
  var genderValue;
  var skillValue;
  var districtValue;
  var residenceValue;

  findSchemeStepFive(this.ageValue,this.genderValue,this.skillValue,this.districtValue,this.residenceValue);

  @override
  State<findSchemeStepFive> createState() => _findSchemeStepFiveState(ageValue,genderValue,skillValue,districtValue,residenceValue);
}

class _findSchemeStepFiveState extends State<findSchemeStepFive> {
  _findSchemeStepFiveState(ageValue,genderValue,skillValue,districtValue,residenceValue);

  bool otherscroll = false;
  bool engLanguage = true;
  bool scroll = false;
  var selectedValue ;
  var allcastList = [];
  var allcastNameDropdownList = [];
  var allcastDropdownvalue;
  TextEditingController othercastController=TextEditingController();
  FocusNode otherFocusNode = FocusNode();

  @override
  void initState() {
    getSharedValue();
    getCaste();
    super.initState();
  }

  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      engLanguage = prefs.getBool('engLanguage')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Container(padding: EdgeInsets.only(left: 5,right: 5),child: Center(child: Text('appbarSecondTitle'.tr,style: TextStyle(fontSize: 9,color: Colors.white),textAlign: TextAlign.center,maxLines: 3,))),
            backgroundColor: Color(0xff7959AC),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.purple[50],
              child: scroll ? Container(height:MediaQuery.of(context).size.height*0.8,child: Center(child: CircularProgressIndicator(),)) :   Column(
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepFour()));
                        },
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20,20, 0),
                    child: Text('step5'.tr, style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding:EdgeInsets.fromLTRB(20, 0,20, 0),
                    child: Divider(color: Colors.black,),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 0),
                    child: Text('step5heading'.tr, style: TextStyle(fontSize: 16, color: Color(0xff7959AC),fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child:  Center(child: Image.asset('assets/images/rbb5.png',fit: BoxFit.fill,width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/2,)),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0,20, 0),
                    child: GroupButton(
                      isRadio: true,
                      onSelected: (val, i, selected) {
                        selectedValue=i+1;
                        print('ssssssss$val');
                        if(i==allcastNameDropdownList.length-1){
                          setState(() {
                            otherscroll=true;
                          });
                        }else{
                          setState(() {
                            otherscroll=false;
                          });
                        }
                      },
                      buttons: allcastNameDropdownList,
                      options: GroupButtonOptions(
                          runSpacing: 10,
                          buttonWidth:double.infinity,
                          buttonHeight: 50,
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
                          alignment: AlignmentDirectional.centerStart,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          unselectedBorderColor:  Color(0xffC5C5C5),
                          selectedBorderColor: Colors.green,
                          selectedTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                          textPadding: EdgeInsets.only(left: 10)
                      ),

                    ),
                  ),
                  otherscroll ?
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10,20, 30),
                    child: editTextSimple(controllers: othercastController,focusNode: otherFocusNode, hint: 'castEditText'.tr, keyboardTypes: TextInputType.name, maxlength: 50,),
                  ) : Padding(padding: const EdgeInsets.fromLTRB(20, 10,20, 10),),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20,20, 10),
                    child: ElevatedButton(
                      child: SizedBox(width: double.infinity,height: 50,child: Center(child: Text('next'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white)))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff7959AC)),
                      ),
                      onPressed: (){
                        if(selectedValue!='other'.tr){
                          if(selectedValue==null){
                            toasts().redToast('warningtoast'.tr);
                          }else{
                            toasts().greenToast('rightsteptoast'.tr);
                            otherFocusNode.unfocus();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepSix(widget.ageValue,widget.genderValue,widget.skillValue,widget.districtValue,widget.residenceValue,selectedValue)));
                          }
                        }else{
                          if(othercastController.text.isEmpty){
                            toasts().redToast('warningtoast'.tr);
                          }else{
                            toasts().greenToast('rightsteptoast'.tr);
                            otherFocusNode.unfocus();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => findSchemeStepSix(widget.ageValue,widget.genderValue,widget.skillValue,widget.districtValue,widget.residenceValue,selectedValue)));
                          }
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: helplineCardView(),
                  ),
                  footer(),
                ],
              ),
            ),
          )
      ),
    );
  }

  Future<void> getCaste() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().casteURL));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          allcastList = getitems;
          getCasteName(allcastList);
          scroll = false;
        });
        //something
      } else {
        toasts().redToast('Please Try Again');
        setState(() {
          scroll = false;
        });
      }
    } else {
      toasts().redToast('Server Error');
      setState(() {
        scroll = false;
      });
    }
  }

  void getCasteName(var clist){
    print('cccccccccccccccccccc-----${clist}');
    for(int i=0;i<clist.length;i++){
      allcastNameDropdownList.insert(0,engLanguage ? clist[i]['caste_title_eng'] : clist[i]['caste_title_hindi']);
    }
    allcastNameDropdownList = allcastNameDropdownList.reversed.toList();
    allcastNameDropdownList.insert(clist.length,"other".tr);
  }
}
