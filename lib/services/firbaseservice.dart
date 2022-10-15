import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry_app/Admin/admin_screen.dart';
import 'package:laundry_app/screens/home/main_screen.dart';

import '../rider/rider_screen.dart';
import '../screens/home/home_screen.dart';

class FirebaseServices{
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference order = FirebaseFirestore.instance.collection('Order');


  User? user = FirebaseAuth.instance.currentUser;


  Future<void> addUser(context, uid)async{

    final QuerySnapshot  result = await users.where('uid',isEqualTo: uid).get();

    List<DocumentSnapshot> document = result.docs;

    if(document.isNotEmpty){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>const MainScreen()));

    }else{


      return users.doc(user!.uid)
          .set({
        'uid':user!.uid,
        'email' : user!.email,
        'name' : user!.displayName,
        'url': user!.photoURL,
        // 'phone_number':user!.phoneNumber,
        // 'type':'user'
      }).then((value){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const MainScreen()));

      })
          .catchError((error)=>print('failed to add user : $error'));
    }
  }
  Future<void> getUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      var email = user!.email;
      var name = user!.displayName;
      var url = user!.photoURL;
      var uid = user!.uid;
      var phone_number = user!.phoneNumber;
      var type = "user";
    });
  }



  userLogin(email,password, context)async{
    try{
      UserCredential userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(userCredential.user!.uid.isNotEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('Successfully login !'),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const MainScreen()));

      }

    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('No user found for this email'),
          ),
        );
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('Wrong password provided for this user'),
          ),
        );
      }
    }
  }
  adminLogin(email,password, context)async{
    try{
      UserCredential userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(userCredential.user!.uid.isNotEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('Successfully login !'),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const AdminScreen()));

      }

    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('No user found for this email'),
          ),
        );
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('Wrong password provided for this user'),
          ),
        );
      }
    }
  }
  userRegister(email,password, context,phone,url,name)async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
        return users.doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'phone_number': phone,
          'name':name,
          'url':url,
          'type':'user',
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content:
            Text('Account has been successfully created !'),
            ),
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const MainScreen()));
        });
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content:
          Text('The account already exists for that email '),
          ),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:
        Text('${e.toString()} '),
        ),
      );
    }
  }
  adminRegister(email,password, context,phone,url,name)async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
        return users.doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'phone_number': phone,
          'name':name,
          'url':url,
          'type':'admin',
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content:
            Text('Account has been successfully created !'),
            ),
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const AdminScreen()));
        });
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('The account already exists for that email '),
          ),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:
        Text('${e.toString()} '),
        ),
      );
    }
  }


  Future<DocumentSnapshot> getUserData() async {
    DocumentSnapshot doc = await users.doc(user!.uid).get();
    return doc;
  }

/// Rider
  riderRegister(email,password, context,phone,url,name)async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
        return users.doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'phone_number': phone,
          'name':name,
          'url':url,
          'type':'rider',
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content:
            Text('Account has been successfully created !'),
            ),
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const AdminScreen()));
        });
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('The account already exists for that email '),
          ),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:
        Text('${e.toString()} '),
        ),
      );
    }
  }
  riderLogin(email,password, context)async{
    try{
      UserCredential userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );

      if(userCredential.user!.uid.isNotEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('Successfully login !'),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const RiderScreen()));

      }

    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('No user found for this email'),
          ),
        );
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('Wrong password provided for this user'),
          ),
        );
      }
    }
  }
  /// SubAdmin
  subAdminRegister(email,password, context,phone)async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
        return users.doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'phone_number': phone,
          'name':'',
          'url':'',
          'type':'admin',
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content:
            Text('Admin has been successfully created sub-Admin-Account!'),
            ),
          );
          Navigator.pop(context);
        });
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
          Text('The account already exists for that email '),
          ),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:
        Text('${e.toString()} '),
        ),
      );
    }
  }

  Future<QuerySnapshot<Object?>> getRider() async {

    QuerySnapshot doc = await users.where('type',isEqualTo: 'rider').get();
    return doc;
  }



}