import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry_app/Admin/about_admin/admin_List.dart';
import 'package:laundry_app/Admin/about_rider/rider_List.dart';
import 'package:laundry_app/Admin/about_user/user_List.dart';
import 'package:laundry_app/Admin/add_rider.dart';
import 'package:laundry_app/Admin/add_sub_admin.dart';
import 'package:laundry_app/Admin/admin_pick_order_list.dart';
import 'package:laundry_app/Admin/manage_order/all_order_list.dart';
import 'package:laundry_app/Admin/manage_order/order_manage.dart';
import 'package:laundry_app/Admin/manage_order/rider_status.dart';
import 'package:laundry_app/provider/order_provider.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../screens/splash/onboardScreen.dart';
import 'admin_pick_order_details.dart';
import 'manage_order/submit_order_manage.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  int? index;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      child:  Container(
                        height: 18.h,
                        width: 28.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffE1E9FC),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 3.h,),
                            Image.asset('assets/images/alluser.png',height: 8.h,),
                            SizedBox(height: 1.h,),
                            Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.h,),
                            Text('All Admin', style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
                      child: Container(
                        height: 18.h,
                        width: 28.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffE1E9FC),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 3.h,),
                            Image.asset('assets/images/rider.png',height: 8.h,),
                            SizedBox(height: 1.h,),
                            Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.h,),
                            Text('All Riders', style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
                      child: Container(
                        height: 18.h,
                        width: 28.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffE1E9FC),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 3.h,),
                            Image.asset('assets/images/customer.png',height: 8.h,),
                            SizedBox(height: 1.h,),
                            Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.h,),
                            Text('All Users', style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                ///    All Order       ////////////////////////////
                // FutureBuilder<QuerySnapshot>(
                //   future: services.order.get(),
                //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (snapshot.hasError) {
                //       return const Text('Some things wrong');
                //     }
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return  Container();
                //     }
                //     return InkWell(
                //       onTap: (){
                //         Navigator.push(context, MaterialPageRoute(builder: (_)=>const AllOrderList()));
                //       },
                //       child:Container(
                //         height: 18.h,
                //         width: 28.w,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //           color: Color(0xffE1E9FC),
                //         ),
                //         child: Column(
                //           children: [
                //             SizedBox(height: 3.h,),
                //             Image.asset('assets/images/order.png',height: 8.h,),
                //             SizedBox(height: 1.h,),
                //             Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                //             SizedBox(height: 0.5.h,),
                //             Text('All Orders', style: GoogleFonts.poppins(
                //               textStyle: TextStyle(
                //                   fontSize: 8.sp,
                //                   fontWeight: FontWeight.w600,
                //                   color: Colors.black),
                //             ),),
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
            SizedBox(height: 2.h,),
            Text('About Order',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
            SizedBox(height: 2.h,),
            ///  2  Order Price       ////////////////////////////
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'Submit').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const SubmitOrderManage()));
                  },
                  child:Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/bill.png',height: 5.h,),
                              SizedBox(width: 2.w,),
                              Text('Make A Bill ', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            ///   3 Order Assign To Rider For Pick        ////////////////////////////
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'acceptThis').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderManage(index: 0,)));
                  },
                  child: Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/assign.png',height: 5.h,),
                              SizedBox(width: 2.w,),
                              Text('Assign Rider for pick', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            ///  4  Rider confirmed       ////////////////////////////
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'ConfirmedForPick').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> RiderStatus(index: 0,)));
                  },
                  child:Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/confirmation.png',height: 5.h,),
                              SizedBox(width: 2.w,),
                              Text('Rider confirm for pick order', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            ///  5  Rider Picked       ////////////////////////////
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'RiderPickOrder').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> RiderStatus(index: 1,)));
                  },
                  child: Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/delivery-man.png',height: 5.h,),
                              SizedBox(width: 2.w,),
                              Text('Rider pick order', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            ///   6 Rider deliver Admin       ////////////////////////////
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'RiderPickOrder').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (_)=>  AdminPickOrderList(index: 0,)));
                  },
                  child: Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/delivery-man.png',height: 5.h,color: Colors.red,),
                              SizedBox(width: 2.w,),
                              Text('Admin pick by rider', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'AdminPickOrder').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>  AdminPickOrderList(index: 1,)));
                  },
                  child: Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/ready.png',height: 5.h,),
                              SizedBox(width: 2.w,),
                              Text('Admin make order for ready', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'ReadyToDeliver').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderManage(index: 1,)));
                  },
                  child:  Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/assign.png',height: 5.h,),
                              SizedBox(width: 2.w,),
                              Text('Assign Rider for deliver', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'ConfirmedDeliver').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> RiderStatus(index: 2,)));
                  },
                  child:Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/confirmation.png',height: 5.h,),
                              SizedBox(width: 2.w,),
                              Text('Rider confirmed for deliver', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h,),
            ///    Rider deliver       ////////////////////////////
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderStatus',isEqualTo: 'Delivered').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Container();
                }
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> RiderStatus(index: 3,)));
                  },
                  child:Container(
                    height: 8.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffE1E9FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/delived.png',height: 5.h,),
                              SizedBox(width: 2.w,),
                              Text('Delivered', style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),),
                            ],
                          ),
                          Text(snapshot.data!.size.toString(),style: TextStyle(color: Colors.red,fontSize: 12.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Divider(),
            /// Add Riders and admin
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddRider()));
                  },
                  child: Container(
                    height: 18.5.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffE1E9FC),
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
                    height: 18.5.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffE1E9FC),
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
            SizedBox(height: 3.h,),


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
