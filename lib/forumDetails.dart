
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/url.dart';
import 'Utilles/action.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/iconSearchbar.dart';
import 'Utilles/primaryActions.dart';
import 'Utilles/toasts.dart';

class forumDetails extends StatefulWidget {
  var fid;
  var imgUrl;

  forumDetails(this.fid,this.imgUrl);

  @override
  State<forumDetails> createState() => _forumDetailsState(fid,imgUrl);
}

class _forumDetailsState extends State<forumDetails> {
  _forumDetailsState(fid,imgUrl);

  bool engLanguage = true;
  var allDetails;
  var allForumDetails;
  var allContentsDetails;
  bool scroll=false;

  @override
  void initState() {
    getSharedValue();
    getAllDetails();
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
        leadingWidth: 20.0,
        shadowColor: Colors.transparent,
        backgroundColor: appcolors.primaryColor,
        iconTheme: IconThemeData(color:appcolors.whiteColor),
        title: Image.asset('assets/icons/yuvalogo.png',width: 150,height: 50,fit:BoxFit.fill,color: Colors.white,),
        actions: [primaryActions(),],
      ),
      body:scroll
          ?  Center(child: const CircularProgressIndicator(strokeWidth: 3,),)
          : SingleChildScrollView(
        child: Container(
          color: appcolors.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    iconSearchbar(),
                    SizedBox(height: 15,),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Image.network(urls().base_url+widget.imgUrl,),
                        ),
                        Positioned(
                            child: Container(
                              color: Colors.orange,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                child: Text(formatDate(allForumDetails['forum_date']),style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: Colors.white),maxLines: 1,),
                              ),
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(engLanguage ? allForumDetails['forum_title_eng'] : allForumDetails['forum_title_hindi'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: Colors.white),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Row(
                        children: [
                          Text('Category : ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 8,color: Colors.orange),),
                          Text(engLanguage ? allForumDetails['service_title_eng'] : allForumDetails['service_title_hindi'],style: TextStyle(fontSize: 8,color: Colors.white),),
                          SizedBox(width: 8,),
                          Text('Author : ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 8,color: Colors.orange),),
                          Text(allForumDetails['author'],style: TextStyle(fontSize: 8,color: Colors.white),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allContentsDetails.length,
                    itemBuilder: (context,index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(engLanguage ? allContentsDetails[index]['heading_english'] : allContentsDetails[index]['heading_hindi'] , style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: appcolors.primaryColor),textAlign: TextAlign.left,),
                          SizedBox(height: 10,),
                          Text('${engLanguage ? removeParagraphTags(allContentsDetails[index]['content_english']) : removeParagraphTags(allContentsDetails[index]['content_hindi'])}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.left,),
                          SizedBox(height: 20,),
                        ],
                      );
                   },

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> getAllDetails() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().forumDetailedURL+'?forum_id=${widget.fid}'));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          allDetails = getitems;
          allForumDetails= getitems['form_details'];
          allContentsDetails=getitems['content'];
          print('fdfdfdf---$allContentsDetails');
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

  String removeParagraphTags(String htmlString) {
    // Remove <p> tags and their content
    return htmlString.replaceAll(RegExp(r'<p[^>]*>'), '').replaceAll(RegExp(r'</p[^>]*>'), '');
  }

  String formatDate(String inputDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('d MMMM, y');
    final dateTime = inputFormat.parse(inputDate);
    // Format the date in the desired format
    final formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }
}
