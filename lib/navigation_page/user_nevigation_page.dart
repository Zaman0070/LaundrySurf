import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/screens/splash/onboardScreen.dart';


import '../screens/home/main_screen.dart';

class UserNavigationPage extends StatefulWidget {
  const UserNavigationPage({Key? key}) : super(key: key);

  @override
  _UserNavigationPageState createState() => _UserNavigationPageState();
}

class _UserNavigationPageState extends State<UserNavigationPage> {
  bool isSigned = false;



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        if (snapShot.data != null) {
          return const MainScreen();
        }
        if(snapShot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ));

        }
        return const OnBoardScreen();

      },
      // Navigator.of(context).pop();
      //Navigator.push(context,  SlidingAnimationRoute(builder: (context) => landingPage));
    );
  }
}
