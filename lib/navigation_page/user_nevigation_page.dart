import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/Admin/admin_screen.dart';
import 'package:laundry_app/screens/auth/login.dart';
import 'package:laundry_app/screens/splash/onboardScreen.dart';
import 'package:laundry_app/services/firbaseservice.dart';


import '../rider/rider_screen.dart';
import '../screens/home/main_screen.dart';

class UserNavigationPage extends StatefulWidget {
  const UserNavigationPage({Key? key}) : super(key: key);

  @override
  _UserNavigationPageState createState() => _UserNavigationPageState();
}

class _UserNavigationPageState extends State<UserNavigationPage> {
  FirebaseServices services = FirebaseServices();



  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<DocumentSnapshot>(
        future: services.getUserData(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.data == null) {
            return const OnBoardScreen();
          }

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor),
                ));
          }
          var data= snapshot.data;
          return   StreamBuilder(

            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapShot) {
              if (data!['type']=='user') {
                return const MainScreen();
              }
               if (data['type']=='admin'){
                return const AdminScreen();
              }
              if (data['type']=='rider'){
                return const RiderScreen();
              }

              return  data['type']=='user'? const LoginScreen(index: 0,):data['type']=='admin'? const LoginScreen(index: 1,):const LoginScreen(index: 2,);

            },
            // Navigator.of(context).pop();
            //Navigator.push(context,  SlidingAnimationRoute(builder: (context) => landingPage));
          );
        });
  }
}
