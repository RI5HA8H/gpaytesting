

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/iconSearchbar.dart';

import 'Models/demoListmodal.dart';
import 'Utilles/action.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/primaryActions.dart';
import 'Utilles/url.dart';
import 'forumDetails.dart';

Future<List<demoListmodal>> studentnoticemodalfunction() async {

  var uri=("https://jsonplaceholder.typicode.com/posts");
  var response=await get(Uri.parse(uri));
  var data=jsonDecode(response.body);
  print('sssssssssssss$data');

  if (response.statusCode == 200) {
    final parsed = data.cast<Map<String, dynamic>>();
    return parsed.map<demoListmodal>((json) => demoListmodal.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load notice');
  }
}


class forum extends StatefulWidget {
  const forum({Key? key}) : super(key: key);

  @override
  State<forum> createState() => _forumState();
}

class _forumState extends State<forum> {

  bool engLanguage = true;
  late Future<List<dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    getSharedValue();
    futureData = fetchData();
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
        body:SingleChildScrollView(
          child: Container(
            color:appcolors.primaryColor,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    children: [
                      iconSearchbar(),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Image.asset('assets/icons/abicon6.png',width: 30,height: 30,),
                          SizedBox(width: 16,),
                          Text('appbarItem6'.tr,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      IntrinsicHeight(child: Divider(color: Colors.grey[500],thickness: 1,)),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),

                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    color: Colors.white,
                    child: FutureBuilder<List<dynamic>>(
                        future: futureData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              height: MediaQuery.of(context).size.height*0.7,
                              child: Center(child: CircularProgressIndicator(
                                color: appcolors.primaryColor,)),
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              height: MediaQuery.of(context).size.height*0.7,
                              child: Center(child: CircularProgressIndicator(
                                color: appcolors.primaryColor,)),
                            );
                          } else {
                            final data = snapshot.data!;
                            print('ddddddddddd---------$data');
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return  Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: InkWell(
                                            child: Container(
                                              color: Colors.grey[100],
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    color: Colors.grey[400],
                                                    height: 130,
                                                      width: double.infinity,
                                                      child: Stack(
                                                        alignment: Alignment.bottomLeft,
                                                        children: [
                                                          Image.network(urls().base_url+item['head_image'],fit: BoxFit.fill,),
                                                          Positioned(
                                                            child: Container(
                                                              color: Colors.orange,
                                                              child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                                                child: Text('${formatDate(item['forum_date'])}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),maxLines: 1,),
                                                              ),),
                                                            ),]
                                                          ),),
                                                  SizedBox(height: 5,),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                    child: Row(
                                                      children: [
                                                        Text('Category : ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 8,color: Colors.orange),),
                                                        Text(engLanguage ? item['service_title_eng'] : item['service_title_hindi'],style: TextStyle(fontSize: 8,color: Colors.black),),
                                                        SizedBox(width: 5,),
                                                        Text('Author : ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 8,color: Colors.orange),),
                                                        Text(item['author'],style: TextStyle(fontSize: 8,color: Colors.black),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                    child: Text(engLanguage ? item['forum_title_eng'] : item['forum_title_hindi'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black),textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                                    child: Text(engLanguage ? item['introduction_eng'] : item['introduction_hindi'],style: TextStyle(fontSize: 8,color: Colors.black),textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            onTap: (){
                                              var fid;
                                              var imgUrl;
                                              fid =  item['id'];
                                              imgUrl =  item['head_image'];
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => forumDetails(fid,imgUrl)));
                                            },
                                          ),
                                        )
                                    ),
                                    IntrinsicHeight(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                    SizedBox(height: 5,)
                                  ],
                                );
                              },
                            );
                          }})
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
        Uri.parse(urls().base_url + allAPI().forumURL));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('Failed to load data');
    }
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

