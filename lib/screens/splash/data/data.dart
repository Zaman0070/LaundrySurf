import 'package:flutter/material.dart';


class SliderModel{

  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath!;
  }

  String getTitle(){
    return title!;
  }

  String getDesc(){
    return desc!;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides =  <SliderModel>[];
  SliderModel sliderModel =  SliderModel();

  //1
  sliderModel.setDesc("Laundry storage tips to keep your family safe from any detergent - related accidents ");
  sliderModel.setTitle("Perfect Equipment");
  sliderModel.setImageAssetPath("assets/images/spl1.png");
  slides.add(sliderModel);

  sliderModel =  SliderModel();

  //2
  sliderModel.setDesc("To little can leave your clothing dirty and too much can leave a residue");
  sliderModel.setTitle("All types of Clothes");
  sliderModel.setImageAssetPath("assets/images/spl2.png");
  slides.add(sliderModel);

  sliderModel =  SliderModel();

  //3
  sliderModel.setDesc("There is not a whole bunch of prep for drying. In most cause, you just throw everything from the washer into the dryer.");
  sliderModel.setTitle("Professional Walk");
  sliderModel.setImageAssetPath("assets/images/spl3.png");
  slides.add(sliderModel);

  sliderModel =  SliderModel();

  return slides;
}