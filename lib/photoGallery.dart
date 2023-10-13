


import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:yuvasathi/photoGalleryAllPhotos.dart';
import 'Utilles/action.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/iconSearchbar.dart';
import 'Utilles/primaryActions.dart';
import 'Utilles/url.dart';

class photoGallery extends StatefulWidget {
  const photoGallery({Key? key}) : super(key: key);

  @override
  State<photoGallery> createState() => _photoGalleryState();
}

class _photoGalleryState extends State<photoGallery> {
  bool engLanguage = true;
  // We will fetch data from this Rest api
  final _baseUrl = urls().base_url+allAPI().photoGalleryURL;

  // At the beginning, we fetch the first 20 posts
  int _page = 1;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http.get(Uri.parse("$_baseUrl?page=$_page"));
      setState(() {
        var alldata=json.decode(res.body);
        _posts = alldata['data']['data'];
        print('pppppppp-------$_posts');
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrongss');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true && _isFirstLoadRunning == false && _isLoadMoreRunning == false && _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res = await http.get(Uri.parse("$_baseUrl?page=$_page"));
        print('zzzzzzzzz-------$res');
        var alldata=json.decode(res.body);
        if(alldata['code']==500){
          setState(() {
            _hasNextPage = false;
          });
        }
        final List fetchedPosts =  alldata['data']['data'];
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
            print('kkkkkk-------$_posts');
          });
        } else {

          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!$err');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    getSharedValue();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
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
        backgroundColor:appcolors.primaryColor,
        iconTheme: IconThemeData(color:appcolors.whiteColor),
        title: Image.asset('assets/icons/yuvalogo.png',width: 150,height: 50,fit:BoxFit.fill,color: Colors.white,),
        actions: [primaryActions(),],
      ),
      body:SingleChildScrollView(
        controller: _controller,
        child: Container(
          color: appcolors.primaryColor,
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: [
                    iconSearchbar(),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Image.asset('assets/icons/abicon8.png',width: 30,height: 30,),
                        SizedBox(width: 16,),
                        Text('appbarItem8'.tr,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
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
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: Colors.white,
                  child: _isFirstLoadRunning
                      ?  Container(height:MediaQuery.of(context).size.height/1.5,child: Center(child: const CircularProgressIndicator(strokeWidth: 3,),))
                      :  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        //controller: _controller,
                        itemCount: _posts.length,
                        itemBuilder: (_, index) =>getRow(index,context),
                      ),

                      // when the _loadMore function is running
                      if (_isLoadMoreRunning == true)
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                      // When nothing else to load
                      if (_hasNextPage == false)
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.green[200],
                              child:  Center(
                                child: Text('noMoreImg'.tr),
                              ),
                            ),
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

  Widget getRow(int index,var snapshot) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10,0, 0),
        height: 200,
        width: double.infinity,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                      border: Border.all(width: 2,color: appcolors.primaryColor),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(9),topRight: Radius.circular(9)),),
                      child: ClipRRect(
                      borderRadius:BorderRadius.only(topLeft: Radius.circular(9),topRight: Radius.circular(9)),
                      child: Image.network(urls().base_url+_posts[index]['media_image'],width: 150,height: 130,fit: BoxFit.cover,))),

                      Container(
                        width: double.infinity,
                        color: appcolors.primaryColor,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Center(child: Text(engLanguage ? _posts[index]['title_eng'] : _posts[index]['title_eng'],style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                      ),
                    ClipRRect(
                      borderRadius:BorderRadius.only(bottomLeft: Radius.circular(9),bottomRight: Radius.circular(9)),
                      child: Container(
                        width: double.infinity,
                        color: appcolors.primaryColor,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Center(child: Text(formatDate(_posts[index]['date']),style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                      ),
                    )
            ],
          ),
          onTap: (){
            var galleryId;
            var galleryTitleEnglish;
            var galleryTitleHindi;
            galleryId=_posts[index]['id'];
            galleryTitleEnglish=_posts[index]['title_eng'];
            galleryTitleHindi=_posts[index]['title_hindi'];
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => photoGalleryAllPhotos(galleryId,galleryTitleEnglish,galleryTitleHindi)));
          },
        )
    );
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
