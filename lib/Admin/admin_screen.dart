import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/Admin/about_admin/admin_List.dart';
import 'package:laundry_app/Admin/about_rider/rider_List.dart';
import 'package:laundry_app/Admin/about_user/user_List.dart';
import 'package:laundry_app/Admin/add_rider.dart';
import 'package:laundry_app/Admin/add_sub_admin.dart';
import 'package:laundry_app/Admin/manage_order/order_manage.dart';
import 'package:laundry_app/provider/order_provider.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../screens/splash/onboardScreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider =Provider.of<OrderProvider>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title:  Text('Admin DashBoard',style: TextStyle(color: Colors.black,fontSize: 18.sp),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(height: 2.h,),
            FutureBuilder<QuerySnapshot>(
              future: services.users
                  .where('type', isEqualTo: 'admin').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const AdminList()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Number of Admin',style: TextStyle(color: const Color(0xff381568),fontSize: 15.sp,fontWeight: FontWeight.bold),),
                        Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            Divider(),
            FutureBuilder<QuerySnapshot>(
              future: services.users
                  .where('type', isEqualTo: 'rider').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const RiderList()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Number of Rider',style: TextStyle(color: const Color(0xff381568),fontSize: 15.sp,fontWeight: FontWeight.bold),),
                        Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            Divider(),
            FutureBuilder<QuerySnapshot>(
              future: services.users
                  .where('type', isEqualTo: 'user').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const UserList()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Number of User',style: TextStyle(color: const Color(0xff381568),fontSize: 15.sp,fontWeight: FontWeight.bold),),
                        Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            Divider(),
            SizedBox(height: 1.h,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddRider()));
                    },
                    child: Container(
                      height: 18.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff27C1F9)),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Image.asset('assets/images/cycle.png'),
                          SizedBox(height: 2.5.h,),
                          Text('Add Rider',style: TextStyle(
                              fontSize: 16.sp,fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),

                    ),
                  ),
                  InkWell(
                    onTap:(){

                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddSubAdmin()));
                    },
                    child: Container(
                      height: 18.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff27C1F9)),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Image.asset('assets/images/admin.png'),
                          SizedBox(height: 2.5.h,),
                          Text('Add SubAdmin',style: TextStyle(
                              fontSize: 16.sp,fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const OrderManage()));
                  },
                  child: Container(
                    height: 18.h,
                    width: 38.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff27C1F9)),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.asset('assets/images/manager.png'),
                        SizedBox(height: 2.5.h,),
                        Text('Order Manager',style: TextStyle(
                            fontSize: 16.sp,fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),

                  ),
                ),
                InkWell(
                  onTap:(){

                  },
                  child: Container(
                    height: 18.h,
                    width: 38.w,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: const Color(0xff27C1F9)),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Image.asset('assets/images/admin.png'),
                        // SizedBox(height: 2.5.h,),
                        // Text('Add SubAdmin',style: TextStyle(
                        //     fontSize: 16.sp,fontWeight: FontWeight.bold
                        // ),)
                      ],
                    ),

                  ),
                ),
              ],
            ),
          ),


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
