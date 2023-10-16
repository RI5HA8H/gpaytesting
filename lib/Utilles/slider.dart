


import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class slider extends StatefulWidget {
  const slider({Key? key}) : super(key: key);

  @override
  State<slider> createState() => _sliderState();
}

class _sliderState extends State<slider> {

  int currentIndex = 0;
  List imageList = [
    {"id": 1, "image_path": 'assets/images/sbanner1.png'},
    {"id": 2, "image_path": 'assets/images/sbanner2.png'},
    {"id": 2, "image_path": 'assets/images/sbanner3.png'},
    {"id": 2, "image_path": 'assets/images/sbanner4.png'},
  ];

  final CarouselController carouselController = CarouselController();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CarouselSlider(
                items: imageList.map((item) => Image.asset(item['image_path'], fit: BoxFit.fill, width: double.infinity,),
                ).toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  height: 100,
                  viewportFraction: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
