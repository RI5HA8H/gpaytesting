
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuvasathi/Resource/Colors/app_colors.dart';
import 'package:yuvasathi/Utilles/allAPI.dart';
import 'package:yuvasathi/Utilles/iconSearchbar.dart';
import 'package:yuvasathi/Utilles/url.dart';
import 'package:yuvasathi/Utilles/searchableDropdown1.dart';
import 'Controllers/homeSearchController.dart';
import 'Models/getAllCategoryModels.dart';
import 'Schemes/schemList.dart';
import 'Utilles/appbarFloatingButton.dart';
import 'Utilles/bottomNavigation.dart';
import 'Utilles/checkInternet.dart';
import 'Utilles/footer.dart';
import 'Utilles/moduleview.dart';
import 'Utilles/primaryActions.dart';
import 'Utilles/searchCardView.dart';
import 'Utilles/searchbar1.dart';
import 'Utilles/searchbar2.dart';
import 'Utilles/searchbar3.dart';
import 'Utilles/toasts.dart';


class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  double gridHeight=1000.00;
  bool engLanguage = true;
  String searchValue = '';
  bool isKeyboardVisible = false;

  final searchControllers controller = Get.put(searchControllers());
  final searchControllers getcontroller = Get.find();

  StreamSubscription? internetconnection;
  bool isoffline = false;
  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
          print(T);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        setState(() {
          isoffline = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => checkInternet()));
        });
      });
    }
  }

  @override
  void initState() {
    getSharedValue();
    CheckUserConnection();
    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => checkInternet()));
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
      super.initState();
    });
    super.initState();
  }

  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      engLanguage = prefs.getBool('engLanguage')!;
    });
  }

  @override
  void dispose() {
    internetconnection!.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return KeyboardVisibility(
      onChanged: (bool visible) {
        setState(() {
          isKeyboardVisible=visible;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: appcolors.primaryColor,
          leadingWidth: 20.0,
          iconTheme: IconThemeData(color:appcolors.whiteColor),
          title: Image.asset('assets/icons/yuvasathi_purewhite.png',width: 120,height: 40,fit:BoxFit.fill),
          actions: [primaryActions()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => Container(
                //height:  getcontroller.activeIndex1.value ? MediaQuery.of(context).size.height*0.18 : MediaQuery.of(context).size.height*0.5,
                color: appcolors.whiteColor,
                child: Container(
                  width: double.infinity,
                  color: appcolors.primaryColor,
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('searchscheme'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.white),),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  color: getcontroller.activeIndex1.value ? appcolors.whiteColor : Colors.transparent ,
                                  child: Text("svn".tr,style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: getcontroller.activeIndex1.value ? appcolors.blackColor : Colors.white),textAlign: TextAlign.center,),
                                ),
                              ),
                              onTap: (){
                                controller.setActiveIndex(true,false,false);
                              },
                            ),
                            InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  color: getcontroller.activeIndex2.value ? appcolors.whiteColor : Colors.transparent ,
                                  child: Text("svd".tr,style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: getcontroller.activeIndex2.value ? appcolors.blackColor : Colors.white),textAlign: TextAlign.center,),
                                ),
                              ),
                              onTap: (){
                                controller.setActiveIndex(false,true,false);
                              },
                            ),
                            InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  color: getcontroller.activeIndex3.value ? appcolors.whiteColor : Colors.transparent ,
                                  child: Text("svas".tr,style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,color: getcontroller.activeIndex3.value ? appcolors.blackColor : Colors.white),textAlign: TextAlign.center,),
                                ),
                              ),

                              onTap: (){
                                controller.setActiveIndex(false,false,true);
                              },
                            ),

                          ],
                        ),
                      ),

                      searchbar2(),
                      searchbar3(),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              )),

              //SearchBar1
              SearchableDropdown(),

              Container(
                height: gridHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/newmbghomepage.png",),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Text('schemescategory'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.white),),
                    ),
                    FutureBuilder<List<getAllCategoryModels>>(
                    future: fetchServices(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: appcolors.whiteColor,strokeWidth: 3,));
                      } else if (snapshot.hasError) {
                        return Center(child: CircularProgressIndicator(color: appcolors.whiteColor,strokeWidth: 3,));
                      } else {
                        final services = snapshot.data!;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: GridView.builder(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                mainAxisExtent: 160,
                              ),
                              itemCount: services.length,
                              itemBuilder: (context, index) {
                                return GridTile(
                                  child: InkWell(
                                    child: moduleview(
                                      title:engLanguage ? services[index].serviceTitleEng : services[index].serviceTitleHindi,
                                      path: services[index].serviceImage,
                                      count: '${services[index].schemeCount}',),
                                    onTap: (){
                                      var catid = services[index].id;
                                      var sponid = '';
                                      var depid = '';
                                      var ageid = '';
                                      var ratid = '';
                                      var castid = '';
                                      var modeid = '';

                                      var engTitle=services[index].serviceTitleEng;
                                      var hinTitle=services[index].serviceTitleHindi;
                                      var serviceURL=services[index].serviceUrl;
                                      var serviceImg=services[index].serviceImage;
                                      var schemeCount=services[index].schemeCount;
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => schemList(catid,sponid,depid,ageid,ratid,castid,modeid,engTitle,hinTitle,serviceURL,serviceImg,schemeCount)));
                                    },
                                  ),
                                );

                              },
                            ),
                          ),
                        );
                      }
                    },
                    ),
                  ]
              ),
          ),
        ],
              ),),
        bottomNavigationBar: bottomNavigation(),
        floatingActionButton: isKeyboardVisible ? SizedBox() : appbarFloatingButton(),
        floatingActionButtonLocation: isKeyboardVisible ? null : FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

Future<List<getAllCategoryModels>> fetchServices() async {
  final response = await http.get(Uri.parse(urls().base_url+allAPI().allCategoryURL));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final List<dynamic> data = jsonData['data'];
    return data.map((serviceJson) => getAllCategoryModels(
      id: serviceJson['id'],
      serviceTitleEng: serviceJson['service_title_eng'],
      serviceTitleHindi: serviceJson['service_title_hindi'],
      serviceUrl: serviceJson['service_url'],
      serviceImage: serviceJson['service_image'],
      schemeCount: serviceJson['scheme_count'],
    )).toList();
  } else {
    throw Exception('Failed to load services');
  }
}

