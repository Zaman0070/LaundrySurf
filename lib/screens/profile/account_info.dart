import 'dart:io';
import 'dart:math';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:sizer/sizer.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  FirebaseServices service = FirebaseServices();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();






  Widget textField(String hintText,String title,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(title,style: TextStyle(fontSize: 14.sp),),
        ),
        SizedBox(height: 1.h,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).splashColor,
          ),
          height: 50.0,
          child:  TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            style:const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 8.0),
              hintText: hintText,
              //  hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Account Info',
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: Container(
        height: 9.h,
        decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(offset: const Offset(3, 3),blurRadius: 6,spreadRadius: 2,color: Colors.grey.shade400)
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 1.h,),
              InkWell(
                onTap: () {
                 setState(() {
                   FirebaseFirestore.instance.collection('users').doc(service.user!.uid).update({
                     'name':nameController.text,
                     'email':emailController.text,
                     'phone_number':phoneController.text,
                   });
                 });
                },
                child: Container(
                  height: 5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff27C1F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:const Center(child: Text('Save',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            SizedBox(height: 1.h,),
            FutureBuilder<DocumentSnapshot>(
                future: service.getUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.data == null) {
                    return Container();
                  }

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
                        ));
                  }
                  return   Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 33,
                              backgroundImage:
                              NetworkImage(
                                  snapshot.data!['url']

                              ),
                            ),
                            Positioned(
                              bottom: -5,
                              right: -15,
                              child: IconButton(
                                  onPressed: () {
                                    bottomSheet();
                                  },
                                  icon:const  Icon(
                                    Icons.add_a_photo,
                                    size: 20,
                                    color: Color(0xff27C1F9)
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Text(snapshot.data!['name'],style: TextStyle(fontSize: 15.sp,color:const Color(0xff381568),fontWeight: FontWeight.bold),),
                      SizedBox(height: 1.h,),
                      Text(snapshot.data!['email'],style: TextStyle(fontSize: 12.sp,color:Colors.grey),),
                    ],
                  );
                }),



            SizedBox(height: 1.h,),

            SizedBox(height: 4.h,),
            textField("Please type your name", "Full Name",nameController),
            SizedBox(height: 1.h,),
            textField("Please type email ", "Email",emailController),
            SizedBox(height: 1.h,),
            textField("Please type phone number", "Phone Number",phoneController)
          ],
        ),
      ),
    );
  }

  Future bottomSheet(){
    return showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: const Text('Camera'),
          onPressed:  (BuildContext context)  {
            setState(() {
              getImage(ImageSource.camera).whenComplete((){
              }
              );
            });
            Navigator.pop(context);
          },
        ),
        BottomSheetAction(
          title: const Text('Gallery'), onPressed: (BuildContext context)    {
          setState(() {
            getImage(ImageSource.gallery);
          });
          Navigator.pop(context);
        },

        ),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );
  }
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    // Get image from gallery.
    var image = await picker.pickImage(source: source);
    setState(() {
      _uploadImageToFirebase(File(image!.path));
    });
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'images/image$randomNumber.jpg';

      // Upload image to firebase.
      final Reference storageReference =
      FirebaseStorage.instance.ref().child(imageLocation);
      final UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;
      setState(() {
        _addPathToDatabase(imageLocation);
      });
    } catch (e) {

    }
  }
  var imageString;
  Future<void> _addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage.instance.ref().child(text);
       imageString = await ref.getDownloadURL();

      // Add location and url to database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(service.user!.uid)
          .update({
        'url': imageString,
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('ok'),
            );
          });
    }
  }
}
