
import 'dart:convert';
import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import '../Utilles/accordion.dart';
import '../Utilles/allAPI.dart';
import '../Utilles/iconSearchbar.dart';
import '../Utilles/primaryActions.dart';
import '../Utilles/slider.dart';
import '../Utilles/toasts.dart';
import '../Utilles/url.dart';
import '../Utilles/webview.dart';
import 'package:http/http.dart' as http;

class schemeDetails1 extends StatefulWidget {
  var scheme_id;
  var scheme_title_eng ;
  var scheme_title_hindi;
  var service_title_eng ;
  var service_title_hindi;
  var departments_title_eng;
  var departments_title_hindi;
  var scheme_logo ;
  var ratting;
  var sponsor_by;
  var residence_by;
  var mode;
  var employee_status;
  var hashtags ;
  var sources_url;
  var overview_eng ;
  var overview_hindi;
  var benefits_eng ;
  var benefits_hindi;
  var eligibility_eng ;
  var eligibility_hindi;
  var requirement_title_eng ;
  var requirement_title_hindi ;

  schemeDetails1(
      this.scheme_id,
      this.scheme_title_eng,
      this.scheme_title_hindi,
      this.service_title_eng,
      this.service_title_hindi,
      this.departments_title_eng,
      this.departments_title_hindi,
      this.scheme_logo,
      this.ratting,
      this.sponsor_by,
      this.residence_by,
      this.mode,
      this.employee_status,
      this. hashtags,
      this.sources_url,
      this.overview_eng,
      this.overview_hindi,
      this.benefits_eng,
      this.benefits_hindi,
      this.eligibility_eng,
      this.eligibility_hindi,
      this.requirement_title_eng,
      this.requirement_title_hindi,
      );

  @override
  State<schemeDetails1> createState() => _schemeDetails1State(
    scheme_id,
    scheme_title_eng,
    scheme_title_hindi,
    service_title_eng,
    service_title_hindi,
    departments_title_eng,
    departments_title_hindi,
    scheme_logo,
    ratting,
    sponsor_by,
    residence_by,
    mode,
    employee_status,
    hashtags,
    sources_url,
    overview_eng,
    overview_hindi,
    benefits_eng,
    benefits_hindi,
    eligibility_eng,
    eligibility_hindi,
    requirement_title_eng,
      requirement_title_hindi
  );
}

class _schemeDetails1State extends State<schemeDetails1> {

  _schemeDetails1State(scheme_id,scheme_title_eng, scheme_title_hindi, service_title_eng, service_title_hindi, departments_title_eng,
      departments_title_hindi, scheme_logo, ratting, sponsor_by, residence_by, mode,
      employee_status, hashtags, sources_url, overview_eng, overview_hindi, benefits_eng,
      benefits_hindi, eligibility_eng, eligibility_hindi, requirement_title_eng, requirement_title_hindi);

  bool engLanguage = true;
  bool eScroll = false;
  int userId = 0;
  bool color = true;

  var sponserITM = ['stateGov'.tr,'centralGov'.tr, 'centralSpon'.tr,];
  var appmodeITM = ['onoffLine'.tr,'online'.tr, 'offline'.tr,];
  var residenceITM = ['arban'.tr, 'rural'.tr,'rl&rbn'.tr,];
  var empStatusITM = ['status1'.tr, 'status2'.tr,'status3'.tr,'status4'.tr, 'status5'.tr,];

  @override
  void initState() {
    getSharedValue();
    super.initState();
  }

  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      engLanguage = prefs.getBool('engLanguage')!;
      userId =prefs.getInt('userID')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: appcolors.primaryColor,
        leadingWidth: 20.0,
        iconTheme: IconThemeData(color:appcolors.whiteColor),
        title: Image.asset('assets/icons/yuvasathi_purewhite.png',width: 120,height: 40,fit:BoxFit.fill),
        actions: [primaryActions()],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: appcolors.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      iconSearchbar(),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Image.network(widget.scheme_logo,width: 30,height: 30,),
                          SizedBox(width: 10,),
                          Container(width:MediaQuery.of(context).size.width*0.76,child: Text(engLanguage ? widget.scheme_title_eng : widget.scheme_title_hindi,style: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                      SizedBox(height: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.asset('assets/images/schemDetaileStaticBanner.jpg'),
                      ),
                      SizedBox(height: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.white,
                          child: Text('${'searchtexthead3'.tr} : ${engLanguage ? '${widget.departments_title_eng}' : '${widget.departments_title_hindi}'}',style: TextStyle(color: Colors.black,fontSize: 8),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: GroupButton(
                            isRadio: true,
                            buttons: [
                              widget.sponsor_by=='1' ?  sponserITM[0] : widget.sponsor_by=='2' ?  sponserITM[1] : sponserITM[2],
                              widget.residence_by=='1' ?  residenceITM[0] :widget.residence_by=='2' ?  residenceITM[1] : residenceITM[2],
                              widget.mode=='1' ?  appmodeITM[1] :  widget.mode=='2' ?  appmodeITM[2] : appmodeITM[0],
                              widget.employee_status=='1' ?  empStatusITM[0] :  widget.employee_status=='2' ?  empStatusITM[1] :  widget.employee_status=='3' ?  empStatusITM[2] :  widget.employee_status=='4' ?  empStatusITM[3] : empStatusITM[4],
                            ],
                            options: GroupButtonOptions(
                              spacing: 2,
                              buttonHeight: 20,
                              groupingType: GroupingType.row,
                              unselectedColor: Colors.white,
                              selectedColor: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              textPadding: EdgeInsets.all(5),
                              mainGroupAlignment: MainGroupAlignment.center,
                              crossGroupAlignment: CrossGroupAlignment.center,
                              selectedTextStyle: TextStyle(color: Colors.black,fontSize: 8),
                              unselectedTextStyle: TextStyle(color: Colors.black,fontSize: 8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                    ],
                  ),
              ),

              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('overview'.tr,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),overflow: TextOverflow.ellipsis,),
                                Container(
                                  child: Row(
                                    children: [
                                      for(int i=1;i<6;i++)
                                        Icon(Icons.star,size: 16,color: i>widget.ratting ? Colors.grey : Colors.orange,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text(engLanguage ? widget.overview_eng : widget.overview_hindi,style: const TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 5,),
                            IntrinsicHeight(child: Divider(color: Colors.grey[300],thickness: 1,)),
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text('benifit'.tr,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 5,),
                            Text(engLanguage ? widget.benefits_eng : widget.benefits_hindi,style: const TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 5,),
                            IntrinsicHeight(child: Divider(color: Colors.grey[300],thickness: 1,)),
                          ],
                        ),
                      ),

                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('eligibility'.tr,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),overflow: TextOverflow.ellipsis,),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5)
                                  ),
                                  child: InkWell(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/2.5,
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      color: Color(0xff9C60FF),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('checkEligibility'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                                          SizedBox(width: 10,),
                                          Image.asset('assets/icons/elegibility.png', width: 15, height: 15,color: Colors.white, ),
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      toasts().greyToast('pleasewait'.tr);
                                      checkEligibility();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text(engLanguage ? widget.eligibility_eng : widget.eligibility_hindi,style: const TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 5,),
                            SizedBox(height: 5,),
                            IntrinsicHeight(child: Divider(color: Colors.grey[300],thickness: 1,)),
                          ],
                        ),
                      ),

                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text('requirement'.tr,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 5,),
                            Text(engLanguage ? widget.requirement_title_eng : widget.requirement_title_hindi,style: const TextStyle(fontSize: 12,color: Colors.black),),
                            SizedBox(height: 5,),
                            IntrinsicHeight(child: Divider(color: Colors.grey[300],thickness: 1,)),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
                        child: ElevatedButton(
                            child: SizedBox(width: double.infinity,height: 50,child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('applyscheme'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white)),
                                SizedBox(width: 10,),
                                Image.asset('assets/icons/apply.png', width: 30, height: 30, ),
                              ],
                            )),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff64C44D)),),
                            onPressed: (){
                              _showRatingAndTermsDialog(context);
                            },
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showRatingAndTermsDialog(BuildContext context) async {
    bool? acceptedTerms = true;
    double userRating = 5.0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('helpfulInfo'.tr,style:TextStyle(fontSize: 12,color: Colors.black),),
              Text('pleaseRateTitle'.tr,style:TextStyle(fontSize: 12,color: Colors.black),),
            ],
          ),
          content: Container(
            height: 220,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  child: RatingBar.builder(
                    initialRating: userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      userRating = rating;
                      print('userRaing--$userRating');
                    },
                  ),
                ),
                
                SizedBox(height: 10),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 24,
                      padding: EdgeInsets.only(left: 20,right: 10),
                      child: Checkbox(
                        visualDensity: VisualDensity(horizontal: -2.0, vertical: -2.0),
                        value: acceptedTerms,
                        onChanged: (value) {
                          setState(() {
                            print('oooo---$value');
                            acceptedTerms = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 5,),
                    Flexible(child: Text('T&C'.tr,style:TextStyle(fontSize: 10,color: Colors.black),)),
                  ],
                ),
                Container(padding: EdgeInsets.only(left: 10,right: 10),child: Text('agreeT&C'.tr,style:TextStyle(fontSize: 8,color: Colors.black),)),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('applyscheme'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white)),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff64C44D)),),
                  onPressed: (){
                    ratingAPI(userRating);
                    Navigator.pop(context);
                    var url=widget.sources_url;
                    print('ooooo-----$url');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => webview(url)));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void ratingAPI(double userRating) async {
    var headers = {
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };

    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().applySchemeURL));
    request.fields.addAll({
      'youth_id': intToBase64(userId),
      'scheme_id': intToBase64(widget.scheme_id),
      'rating': userRating.toString()
    });

    //print('ggggg1----${intToBase64(userId)}');
    //print('ggggg2----${intToBase64(widget.scheme_id)}');

    request.headers.addAll(headers);

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if(results['code']==200){
        toasts().greenToast(results['msg']);
      }else{
        if(results['code']==500){
          toasts().redToast(results['msg']);
        }else{
          toasts().redToast('Please Try Again');
        }
      }
    }
    else {
      toasts().redToast('Server Error');
    }
  }

  void checkEligibility() async {
    var headers = {
      'Authorization': 'Basic eXV2YXNhdGhpLWRldmVsb3BlcjoyOTZkNjFjOWZlMjI2NDc4NTE1ZDVhMzY5ZDI2MzM5Mw=='
    };

    var request = http.MultipartRequest('POST', Uri.parse(urls().base_url + allAPI().checkEligibilityURL));
    request.fields.addAll({
      'youth_id': intToBase64(userId),
      'scheme_id': intToBase64(widget.scheme_id)
    });

    //print('ggggg1----${intToBase64(userId)}');
    //print('ggggg2----${intToBase64(widget.scheme_id)}');

    request.headers.addAll(headers);

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      //print(await 'aaaaaaaaa-----${results}');
      if(results['code']==419){
        //toasts().greenToast('completeProfileMsg'.tr);
        //setState(() {eScroll = false;});
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                text: 'completeProfileMsg'.tr));
      }else{
        if(results['code']==319){
          //toasts().redToast('eligibilitySuccessMsg'.tr);
          //setState(() {eScroll = false;});
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.success,
                  text: 'eligibilitySuccessMsg'.tr));
        }else{
          //toasts().redToast('Please Try Again');
          //setState(() {eScroll = false;});
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.question,
                  text: 'Please Try Again'));
        }
      }
    }
    else {
      //toasts().redToast('Server Error');
      //setState(() {eScroll = false;});
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              text: 'Oops Server Error'));
    }
  }

  String intToBase64(int value) {
    final encoded = base64Encode(utf8.encode(value.toString()));
    return encoded;
  }

}

