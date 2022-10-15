import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/Rider/pick_order_list.dart';
import 'package:sizer/sizer.dart';

import '../screens/splash/onboardScreen.dart';
import '../services/firbaseservice.dart';

class RiderScreen extends StatefulWidget {
  const RiderScreen({Key? key}) : super(key: key);

  @override
  State<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<RiderScreen> {
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title:  Text('Rider Dashboard',style: TextStyle(color: Colors.black,fontSize: 18.sp),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> PickOrderList(index: 0,)));
                },
                child: Container(
                  height: 12.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: const Color(0xff27C1F9).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 2.h,),
                      Image.asset('assets/images/pick.png',height: 7.h,color: Colors.red,),
                      SizedBox(width: 2.h,),
                      Text('Pickup Order List',style: TextStyle(
                          fontSize: 16.sp,fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> PickOrderList(index: 1,)));
                },
                child: Container(
                  height: 12.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: const Color(0xff27C1F9).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 2.h,),
                      Image.asset('assets/images/delivery.png',height: 7.h,color: Colors.red,),
                      SizedBox(width: 2.h,),
                      Text('Deliver Order List',style: TextStyle(
                          fontSize: 16.sp,fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h,),


            InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            height: 20.h,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Are you sure logout ?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    SizedBox(width: 5.w),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          FirebaseAuth.instance.signOut();
                                        });
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const OnBoardScreen()));
                                      },
                                      child: const Text('Delete'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Text('Logout',style: TextStyle(color: const Color(0xff381568),fontSize: 16.sp,fontWeight: FontWeight.w400),)),
          ],
        ),
      ),


    );
  }
}
