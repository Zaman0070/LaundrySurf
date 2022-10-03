import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laundry_app/screens/auth/option_Screen.dart';
import 'package:sizer/sizer.dart';

import 'data/data.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {

  List<SliderModel> mySlides = <SliderModel>[];
  int slideIndex = 0;
  PageController? controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? const Color(0xff27C1F9) : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySlides = getSlides();
    controller =  PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff3C8CE7), Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              SlideTile(
                imagePath: mySlides[0].getImageAssetPath(),
                title: mySlides[0].getTitle(),
                desc: mySlides[0].getDesc(),
              ),
              SlideTile(
                imagePath: mySlides[1].getImageAssetPath(),
                title: mySlides[1].getTitle(),
                desc: mySlides[1].getDesc(),
              ),
              SlideTile(
                imagePath: mySlides[2].getImageAssetPath(),
                title: mySlides[2].getTitle(),
                desc: mySlides[2].getDesc(),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 2 ? Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  controller!.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: const Text(
                  "SKIP",
                  style: TextStyle(color: Color(0xFF27C1F9), fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                  ],),
              ),
              FlatButton(
                onPressed: (){
                  print("this is slideIndex: $slideIndex");
                  controller!.animateToPage(slideIndex + 1, duration: const Duration(milliseconds: 500), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: const Text(
                  "NEXT",
                  style: TextStyle(color: Color(0xFF27C1F9), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ): InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const OptionScreen()));
          },
          child: Container(
            height: Platform.isIOS ? 70 : 60,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text(
              "GET STARTED NOW",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  String? imagePath, title, desc;

  SlideTile({Key? key, this.imagePath, this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath!,height: 15.h,),
          const SizedBox(
            height: 40,
          ),
          Text(title!, textAlign: TextAlign.center,style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),),
          const SizedBox(
            height: 20,
          ),
          Text(desc!, textAlign: TextAlign.center,style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }
}
