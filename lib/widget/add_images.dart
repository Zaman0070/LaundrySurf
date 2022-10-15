import 'dart:io';
import 'dart:math';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:laundry_app/provider/order_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';



class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploading = false;
  double val = 0;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

   final List<File> _image =[];
  List<XFile> image =[];
  String? url;
  List<String> arImageUrl = [];

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {


    Future<void> removeImageFromUrl(String url) async {
      try {
        Reference ref = FirebaseStorage.instance.refFromURL(url);
        await ref.delete();
      } catch (e) {

      }
    }

    Future<List<String>?> uploadImages(List<File> images) async {
      var catProvider = Provider.of<OrderProvider>(context,listen: false);
      if (images.isEmpty) return null;


      List<String> downloadUrls = [];
      int randomNumber = Random().nextInt(1000000);
      String imageLocation = 'Post/image$randomNumber.jpg';

      await Future.forEach(images, (File image) async {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(imageLocation);
        final UploadTask uploadTask = ref.putFile(image);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          url = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(catProvider.getImage(url));
      });

      return downloadUrls;
    }




    Future<List<String>> uploadMultiImage(XFile images) async {
      var catProvider = Provider.of<OrderProvider>(context,listen: false);
      List<String> downloadUrls = [];
      String imageName =
          'userImage/${DateTime.now().microsecondsSinceEpoch}';
     // if (images.isEmpty) return null;
      Reference ref = FirebaseStorage.instance.ref().child(images.name);
      final UploadTask uploadTask = ref.putFile(File(images.path));
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      url = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(catProvider.getImage(url));

      return downloadUrls;
    }


    void uploadFunction(List<XFile> imagess){
      for(int i=0; i< imagess.length; i++){
        var imageUrl =  uploadMultiImage(imagess[i]);
        arImageUrl.add(imageUrl.toString());
      }
    }

    Widget? bottomSheet(){
      showAdaptiveActionSheet(
        context: context,
        actions: <BottomSheetAction>[
          BottomSheetAction(
            title: const Text('Camera'),
            onPressed: (BuildContext context)  {
              setState(() {
                chooseImage(ImageSource.camera).whenComplete((){
                  uploadImages(_image);
                }
                );
              });
              Navigator.pop(context);
            },
          ),
          BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: (BuildContext context)  {
              setState(() {
                chooseMultiImage(ImageSource.gallery).whenComplete((){
                  uploadFunction(image);
                }
                );
              });

              Navigator.pop(context);
            },
          ),
        ],
        cancelAction: CancelAction(title: const Text('Cancel')),
      );
      return null;
    }

    return Stack(
      children: [
        if(_image.length != null)
        GridView.builder(
            itemCount: _image.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5),
            itemBuilder: (context, int index) {
              return index == 0
                  ? IconButton(
                      icon: const Icon(Icons.add,size: 45,),
                      onPressed: (){
                        !uploading ? bottomSheet() : null;
                       // uploadImages(_image);
                      },
                  )
                  :Stack(
                    children: [

                      Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(

                        image: DecorationImage(
                            image: FileImage(_image[index-1]),
                            fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
                      Positioned(
                        bottom: 18,
                          left:18,
                          child: IconButton(onPressed: (){
                           removeImageFromUrl(url!);
                           setState(() {
                             _image.removeAt(index-1);
                           });
                          }, icon: const Icon(Icons.cancel_outlined,color: Colors.red,size: 20,))),
                    ],
                  );
            }),
        if(image.length != null)
          GridView.builder(
              itemCount: image.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5),
              itemBuilder: (context, int index) {
                return index ==  image.length
                    ? IconButton(
                  icon: const Icon(Icons.add,size: 45,),
                  onPressed: (){
                    !uploading ? bottomSheet() : null;
                    // uploadImages(_image);
                  },
                )
                    :Stack(
                  children: [

                    Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(

                        image: DecorationImage(
                            image: FileImage(File(image[index].path)),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Positioned(
                        bottom: 18,
                        left:18,
                        child: IconButton(onPressed: (){
                          removeImageFromUrl(url!);
                          setState(() {
                            image.removeAt(index);
                          });
                        }, icon: const Icon(Icons.cancel_outlined,color: Colors.red,size: 20,))),
                  ],
                );
              }),
        uploading
            ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'uploading...',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator(
                  value: val,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                )
              ],
            ))
            : Container(),
      ],
    );
  }


  chooseImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }
  chooseMultiImage(ImageSource source) async {
    try{
      final List<XFile>? selectedImages = await picker.pickMultiImage();
      if (selectedImages!.isNotEmpty) {
        image.addAll(selectedImages);
      }
    }
    catch (e){
      print('something wrong $e');
    }
    setState(() {
    });
  }





}