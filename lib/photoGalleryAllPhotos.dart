


import 'dart:convert';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:http/http.dart' as http;
import 'Utilles/action.dart';
import 'Utilles/allAPI.dart';
import 'Utilles/iconSearchbar.dart';
import 'Utilles/primaryActions.dart';
import 'Utilles/toasts.dart';
import 'Utilles/url.dart';

class photoGalleryAllPhotos extends StatefulWidget {
  var galleryId;
  var galleryEngTitle;
  var galleryHindiTitle;

  photoGalleryAllPhotos(this.galleryId,this.galleryEngTitle,this.galleryHindiTitle);

  @override
  State<photoGalleryAllPhotos> createState() => _photoGalleryAllPhotosState(galleryId,galleryEngTitle,galleryHindiTitle);
}

class _photoGalleryAllPhotosState extends State<photoGalleryAllPhotos> {
  _photoGalleryAllPhotosState(galleryId,galleryEngTitle,galleryHindiTitle);
  bool engLanguage = true;
  bool scroll = false;
  var allPhotos;

  @override
  void initState() {
    getAllPhotos();
    getSharedValue();
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
        backgroundColor:appcolors.primaryColor,
        iconTheme: IconThemeData(color:appcolors.whiteColor),
        title: Image.asset('assets/icons/yuvalogo.png',width: 150,height: 50,fit:BoxFit.fill,color: Colors.white,),
        actions: [primaryActions(),],
      ),
      body:SingleChildScrollView(
        child: Container(
          color: appcolors.primaryColor,
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
                        Container(width: MediaQuery.of(context).size.width*0.7,child: Text(engLanguage ? widget.galleryEngTitle : widget.galleryHindiTitle,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,)),
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
                  child: scroll
                      ?  Container(height:MediaQuery.of(context).size.height/1.5,child: Center(child: const CircularProgressIndicator(strokeWidth: 3,),))
                      :  Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          //controller: _controller,
                          itemCount: allPhotos.length,
                          itemBuilder: (_, index) =>getRow(index,context),
                        ),
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
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        height: 180,
        width: double.infinity,
        child: InkWell(
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2,color: appcolors.primaryColor),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(urls().base_url+allPhotos[index]['gallery_image'],width: 120,height: 120,fit: BoxFit.cover,))),
          onTap: (){
            final imageProvider = Image.network(urls().base_url+allPhotos[index]['gallery_image']).image;
            showImageViewer(context, imageProvider, onViewerDismissed: () {
              print("dismissed");
            });
          },
        )
    );
  }

  Future<void> getAllPhotos() async {
    setState(() {scroll = true;});
    var request = http.Request('GET', Uri.parse(urls().base_url + allAPI().totalPhotoURL+'?album_id=${widget.galleryId}'));

    var response = await request.send();

    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['code'] == 200) {
        var getitems = results['data'];
        setState(() {
          allPhotos = getitems;
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
}
