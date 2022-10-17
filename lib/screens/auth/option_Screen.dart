import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/provider/user_provider.dart';
import 'package:laundry_app/screens/auth/login.dart';
import 'package:laundry_app/screens/auth/loginadmin.dart';
import 'package:laundry_app/screens/auth/loginrider.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  FirebaseServices services = FirebaseServices();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h,),
            Text('Do You?',style: TextStyle(fontSize: 20.sp,color: const Color(0xff27C1F9),fontWeight: FontWeight.w500),),
            SizedBox(height: 1.5.h,),
            const Text('Choose the role that best describe you right now.'),
            SizedBox(height: 4.h,),
        InkWell(
          onTap: (){
            setState(() {
              index= 0;
            });
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
          },
          child: Container(
            height: 10.h,
            width: 100.w,
            decoration: BoxDecoration(
              border: Border.all(color:index == 0 ? const Color(0xff27C1F9) :Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xff27C1F9).withOpacity(0.3),
                    child: const Icon(Icons.person,color:Color(0xff27C1F9),),
                  ),
                  SizedBox(width: 12.w,),
                  Text('Login as a User',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h,),
        InkWell(
          onTap: (){
            setState(() {
              index = 1;
            });

            Navigator.push(context, MaterialPageRoute(builder: (_)=>const AdminLoginScreen()));
          },
          child: Container(
            height: 10.h,
            width: 100.w,
            decoration: BoxDecoration(
              border: Border.all(color:index == 1 ? const Color(0xff27C1F9) :Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xff27C1F9).withOpacity(0.3),
                    child: Image.asset('assets/icons/user.png',height: 3.h,color:const Color(0xff27C1F9),),
                  ),
                  SizedBox(width: 12.w,),
                  Text('Login as a Admin',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h,),
        InkWell(
          onTap: (){
            setState(() {
              index =  2;
            });
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const RiderLoginScreen()));
          },
          child: Container(
            height: 10.h,
            width: 100.w,
            decoration: BoxDecoration(
              border: Border.all(color:index == 2 ? const Color(0xff27C1F9) :Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xff27C1F9).withOpacity(0.3),
                    child: Image.asset('assets/icons/rider.png',height: 3.h,color:const Color(0xff27C1F9),),
                  ),
                  SizedBox(width: 12.w,),
                  Text('Login as a Rider',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
        ),
            SizedBox(height: 30.h,),
          ],
        ),
      ),
    );
  }
}
