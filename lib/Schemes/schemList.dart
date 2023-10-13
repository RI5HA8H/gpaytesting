
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:group_button/group_button.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/filter.dart';
import 'package:yuvasathi/Utilles/iconSearchbar.dart';
import '../Models/demoListmodal.dart';
import '../SchemeDetails/schemeDetails1.dart';
import '../Utilles/allAPI.dart';
import '../Utilles/appbarFloatingButton.dart';
import '../Utilles/bottomNavigation.dart';
import '../Utilles/primaryActions.dart';
import '../Utilles/ratingFilter.dart';
import '../Utilles/toasts.dart';
import '../Utilles/url.dart';
import '../homePage.dart';
import '../loginPage.dart';


class schemList extends StatefulWidget {
  var catid;
  var sponid;
  var depid;
  var ageid;
  var ratid;
  var castid;
  var modeid;

  var engTitle;
  var hinTitle;
  var serviceURL;
  var serviceImg;
  var schemeCount;


  schemList(this.catid,this.sponid,this.depid,this.ageid,this.ratid,this.castid,this.modeid,this.engTitle,this.hinTitle,this.serviceURL,this.serviceImg,this.schemeCount);


  @override
  State<schemList> createState() => _schemListState(catid,sponid,depid,ageid,ratid,castid,modeid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount);
}

class _schemListState extends State<schemList> {
  _schemListState(catid,sponid,depid,ageid,ratid,castid,modeid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount);

  // We will fetch data from this Rest api
  final _baseUrl = urls().base_url+allAPI().schemeURL;

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
      final res = await http.get(Uri.parse("$_baseUrl?page=$_page&category=${widget.catid}&sponsor_by=${widget.sponid}&department=${widget.depid}&age=${widget.ageid}&rating=${widget.ratid}&caste=${widget.castid}&mode=${widget.modeid}"));
      setState(() {
        var alldata=json.decode(res.body);
        _posts = alldata['data']['data'];
      });
    } catch (err) {
      toasts().redToast('We could not find any schemes');
      if (kDebugMode) {
        print('Something went wrongss$err');
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
        final res = await http.get(Uri.parse("$_baseUrl?page=$_page&category=${widget.catid}&sponsor_by=${widget.sponid}&department=${widget.depid}&age=${widget.ageid}&rating=${widget.ratid}&caste=${widget.castid}&mode=${widget.modeid}"));
        //print('zzzzzzzzz-------$res');
        var alldata=json.decode(res.body);
        //print('nnnn00000000000000000$alldata');
        if(alldata['code']==301){
          setState(() {
            _hasNextPage = false;
          });
        }
        final List fetchedPosts =  alldata['data']['data'];
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
            //print('kkkkkk-------$_posts');
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
  bool engLanguage = true;

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

  var sponserITM = ['stateGov'.tr,'centralGov'.tr, 'centralSpon'.tr,];
  var appmodeITM = ['onoffLine'.tr,'online'.tr, 'offline'.tr,];
  var residenceITM = ['arban'.tr, 'rural'.tr,'rl&rbn'.tr,];
  var empStatusITM = ['status1'.tr, 'status2'.tr,'status3'.tr,'status4'.tr, 'status5'.tr,];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homePage()), (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Color(0xffB43F8A),
          leadingWidth: 20.0,
          iconTheme: IconThemeData(color:appcolors.whiteColor),
          title: Image.asset('assets/icons/yuvasathi_purewhite.png',width: 120,height: 40,fit:BoxFit.fill),
          actions: [primaryActions()],
        ),
        body:  Column(
          children: [
            Container(
              //height: MediaQuery.of(context).size.height*0.2,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              color: Color(0xffB43F8A),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 // iconSearchbar(),
                 // SizedBox(height: 10,),
                  Row(
                    children: [
                      Image.network(urls().base_url+widget.serviceImg,width: 30,height: 30,),
                      SizedBox(width: 10,),
                      Text('${engLanguage ? widget.engTitle : widget.hinTitle}',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Divider(color: Colors.grey[500],thickness: 1,),
                  SizedBox(height: 5,),

                  ElevatedButton(
                    child: SizedBox(width: double.infinity,height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('filterresult'.tr,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white)),
                          Icon(Icons.filter_alt_outlined,color: Colors.white,),
                        ],
                    )),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green),),
                    onPressed: (){
                      _showPicker(context: context);
                    },
                  ),
                ],
              ),
            ),


            Expanded(
              child: Container(
                //height: MediaQuery.of(context).size.height*0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/listbg.png",),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child:  _isFirstLoadRunning
                            ? Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height/2,
                          child: const Center(
                            child: const CircularProgressIndicator(strokeWidth: 3,),
                          ),
                        )
                            : Column(
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
                                padding:  EdgeInsets.all(5),
                                color: Colors.green[200],
                                child:  Center(
                                  child: Text('noMoreScheme'.tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                ),
                              ),

                          ],
                        ),
                      ),

                      if(_posts.isEmpty)
                        _isFirstLoadRunning ? Container() : Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                          padding: EdgeInsets.all(20),
                          child: Center(child: Text('search1ifempty'.tr,style: TextStyle(fontSize: 10,color: Colors.black),)),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
       /* bottomNavigationBar: bottomNavigation(),
        floatingActionButton: appbarFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      ),
    );
  }
  Widget getRow(int index,var snapshot) {
    return Stack(
      children: [
        Container(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Card(
                margin: EdgeInsets.fromLTRB(20,20,20,20),
                color: Colors.white,
                shadowColor: Colors.black,
                elevation: 5,
                child: Container(
                  height: 160,
                  child: ListTile(
                    onTap: () async {
                      var scheme_id =  _posts[index]['id'];
                      var scheme_title_eng =  _posts[index]['scheme_title_eng'];
                      var scheme_title_hindi=  _posts[index]['scheme_title_hindi'];
                      var service_title_eng =  _posts[index]['service_title_eng'];
                      var service_title_hindi=  _posts[index]['service_title_hindi'];
                      var departments_title_eng =  _posts[index]['departments_title_eng'];
                      var departments_title_hindi=  _posts[index]['departments_title_hindi'];
                      var scheme_logo =  urls().base_url+widget.serviceImg;
                      var ratting=  _posts[index]['ratting'];
                      var sponsor_by=  _posts[index]['sponsor_by'];
                      var residence_by=  _posts[index]['residence_by'];
                      var mode=  _posts[index]['mode'];
                      var employee_status=  _posts[index]['employee_status'];
                      var hashtags =  _posts[index]['hashtags'];
                      var sources_url=  _posts[index]['sources_url'];
                      var overview_eng =  convertHtmlToPlainText(_posts[index]['overview_eng']);
                      var overview_hindi=  convertHtmlToPlainText(_posts[index]['overview_hindi']);
                      var benefits_eng =  convertHtmlToPlainText(_posts[index]['benefits_eng']);
                      var benefits_hindi=  convertHtmlToPlainText(_posts[index]['benefits_hindi']);
                      var eligibility_eng =  convertHtmlToPlainText(_posts[index]['eligibility_eng']);
                      var eligibility_hindi=  convertHtmlToPlainText(_posts[index]['eligibility_hindi']);
                      var requirement_title_eng =  convertHtmlToPlainText(_posts[index]['requirement_title_eng']);
                      var requirement_title_hindi =  convertHtmlToPlainText(_posts[index]['requirement_title_hindi']);

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      int? userId =prefs.getInt('userID');

                      if(userId==0 || userId==null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => schemeDetails1(
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
                        )));
                      }
                    },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(width: MediaQuery.of(context).size.width*0.9,child: Text('${engLanguage ? _posts[index]['scheme_title_eng'] : _posts[index]['scheme_title_hindi']}',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 10),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                        SizedBox(height: 5,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.86,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GroupButton(
                              onDisablePressed: null,
                              isRadio: true,
                              buttons: [
                                _posts[index]['sponsor_by']=='1' ?  sponserITM[0] : _posts[index]['sponsor_by']=='2' ?  sponserITM[1] : sponserITM[2],
                                _posts[index]['residence_by']=='1' ?  residenceITM[0] : _posts[index]['residence_by']=='2' ?  residenceITM[1] : residenceITM[2],
                                _posts[index]['mode']=='1' ?  appmodeITM[1] : _posts[index]['mode']=='2' ?  appmodeITM[2] : appmodeITM[0],
                                _posts[index]['employee_status']=='1' ?  empStatusITM[0] :  _posts[index]['employee_status']=='2' ?  empStatusITM[1] :  _posts[index]['employee_status']=='3' ?  empStatusITM[2] :  _posts[index]['employee_status']=='4' ?  empStatusITM[3] : empStatusITM[4],
                              ],
                              options: GroupButtonOptions(
                                spacing: 3,
                                  buttonHeight: 20,
                                  groupingType: GroupingType.row,
                                  unselectedColor: Colors.grey[200],
                                  selectedColor:Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                textPadding: EdgeInsets.all(5),
                                mainGroupAlignment: MainGroupAlignment.start,
                                crossGroupAlignment: CrossGroupAlignment.start,
                                selectedTextStyle: TextStyle(color: Colors.black,fontSize: 6),
                                unselectedTextStyle: TextStyle(color: Colors.black,fontSize: 6),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(width: MediaQuery.of(context).size.width*0.86,child: Text('${engLanguage ?  convertHtmlToPlainText(_posts[index]['overview_eng']) :  convertHtmlToPlainText(_posts[index]['overview_hindi']) }',style: const TextStyle(fontSize: 10,color: Colors.black),maxLines: 4,overflow: TextOverflow.ellipsis,)),
                        SizedBox(height: 10,),
                      ],
                    ),

                  ),
                ),
              ),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0,0,30,10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: GestureDetector(
                      child: Container(
                        width:60,
                        height: 24,
                        color: Color(0xff58BB16),
                        child: Center(child: Icon(Icons.arrow_right_alt,color: Colors.white,size: 24,)),
                      ),
                      onTap: () async {
                        var scheme_id =  _posts[index]['id'];
                        var scheme_title_eng =  _posts[index]['scheme_title_eng'];
                        var scheme_title_hindi=  _posts[index]['scheme_title_hindi'];
                        var service_title_eng =  _posts[index]['service_title_eng'];
                        var service_title_hindi=  _posts[index]['service_title_hindi'];
                        var departments_title_eng =  _posts[index]['departments_title_eng'];
                        var departments_title_hindi=  _posts[index]['departments_title_hindi'];
                        var scheme_logo =  urls().base_url+widget.serviceImg;
                        var ratting=  _posts[index]['ratting'];
                        var sponsor_by=  _posts[index]['sponsor_by'];
                        var residence_by=  _posts[index]['residence_by'];
                        var mode=  _posts[index]['mode'];
                        var employee_status=  _posts[index]['employee_status'];
                        var hashtags =  _posts[index]['hashtags'];
                        var sources_url=  _posts[index]['sources_url'];
                        var overview_eng =  convertHtmlToPlainText(_posts[index]['overview_eng']);
                        var overview_hindi=  convertHtmlToPlainText(_posts[index]['overview_hindi']);
                        var benefits_eng =  convertHtmlToPlainText(_posts[index]['benefits_eng']);
                        var benefits_hindi=  convertHtmlToPlainText(_posts[index]['benefits_hindi']);
                        var eligibility_eng =  convertHtmlToPlainText(_posts[index]['eligibility_eng']);
                        var eligibility_hindi=  convertHtmlToPlainText(_posts[index]['eligibility_hindi']);
                        var requirement_title_eng = convertHtmlToPlainText(_posts[index]['requirement_title_eng']);
                        var requirement_title_hindi =  convertHtmlToPlainText(_posts[index]['requirement_title_hindi']);

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        int? userId =prefs.getInt('userID');

                        if(userId==0 || userId==null){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginPage()));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => schemeDetails1(
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
                          )));
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10,10,0,0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Color(0xff783FD5),
                    child: Row(
                      children: [
                        Text('rating'.tr+' '+'${_posts[index]['ratting']}/5',style: TextStyle(color: Colors.white,fontSize: 8),),
                        SizedBox(width: 2,),
                        Icon(Icons.star,color: Colors.orange,size: 12,)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20,10,0,0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width*0.65,
                    ),
                    padding: EdgeInsets.all(5),
                    color: Colors.grey[200],
                    child: Text('${engLanguage ? '${_posts[index]['departments_title_eng']}' : '${_posts[index]['departments_title_hindi']}'}',style: TextStyle(color: Colors.black,fontSize: 8),maxLines: 1,),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }

  void _showPicker({required BuildContext context,}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('filterresult'.tr),
          content: Container(
            width: double.maxFinite,
            child:filter(catid: widget.catid,engTitle: widget.engTitle,hinTitle: widget.hinTitle,serviceURL: widget.serviceURL,serviceImg: widget.serviceImg,schemeCount: widget.schemeCount,)
          ),
        );
      },
    );
  }

  String convertHtmlToPlainText(String htmlText) {
    final String plainText = htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
    return plainText;
  }



}

