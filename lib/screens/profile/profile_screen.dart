import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/screens/splash/onboardScreen.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:sizer/sizer.dart';

import 'account_info.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Center(child: Text('Setting',style: TextStyle(fontSize: 15.sp),)),
            SizedBox(height: 1.h,),
            FutureBuilder<DocumentSnapshot>(
                future: services.getUserData(),
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
                          ],
                        ),
                      ),
                      Text(snapshot.data!['name'],style: TextStyle(fontSize: 15.sp,color:const Color(0xff381568),fontWeight: FontWeight.bold),),
                      SizedBox(height: 1.h,),
                      Text(snapshot.data!['email'],style: TextStyle(fontSize: 12.sp,color:Colors.grey),),
                    ],
                  );
                }),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/bach.png',height: 4.h,),
                    SizedBox(width: 1.w,),
                    Text('Gold member',style: TextStyle(fontSize: 16.sp,color:Colors.grey[600]),),

                  ],
                ),
                Text('10 point',style: TextStyle(fontSize: 16.sp,color:Colors.grey[600]),),

              ],
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 1.2.h,
             width: 100.w,
             decoration: BoxDecoration(
               color: const Color(0xff27C1F9).withOpacity(0.3),
               borderRadius: BorderRadius.circular(10),
             ),
              child: Row(
                children: [
                  Container(
                    height: 1.2.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      color:  const Color(0xff27C1F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            Container(
              height: 15.5.h,
              width: 100.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const AccountInfo()));
                    },
                    child: Container(
                        height: 7.5.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft:Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          border: Border.all(color: Colors.grey.shade300)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Account Info ',style: TextStyle(fontSize: 15.sp),),
                              Image.asset('assets/logo/person.png',height: 3.5.h,)
                            ],
                          ),
                        )),
                  ),
                  Container(
                      height: 7.7.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius:const  BorderRadius.only(
                            bottomLeft:Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('My Address ',style: TextStyle(fontSize: 14.5.sp),),
                            Image.asset('assets/logo/address.png',height: 3.5.h,)
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            Row(
              children: [
                Text('Other',style: TextStyle(color: const Color(0xff381568),fontSize: 17.sp,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 2.h,),
            Container(
              height: 22.2.h,
              width: 100.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 7.3.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft:Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Report & Feedback ',style: TextStyle(fontSize: 15.sp),),
                            Image.asset('assets/logo/chat.png',height: 3.5.h,)
                          ],
                        ),
                      )),
                  Container(
                      height: 7.3.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('App Notification ',style: TextStyle(fontSize: 15.sp),),
                            Image.asset('assets/logo/notification.png',height: 3.5.h,)
                          ],
                        ),
                      )),
                  Container(
                      height: 7.3.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft:Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Setting ',style: TextStyle(fontSize: 15.sp),),
                            Image.asset('assets/logo/sett.png',height: 3.5.h,)
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(height: 2.h,),
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
      )),
    );
  }
}
