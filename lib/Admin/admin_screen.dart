import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/Admin/about_admin/admin_List.dart';
import 'package:laundry_app/Admin/about_user/user_List.dart';
import 'package:laundry_app/Admin/add_rider.dart';
import 'package:laundry_app/Admin/add_sub_admin.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:sizer/sizer.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  FirebaseServices services = FirebaseServices();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor == Colors.white
          ? Color(0xffF0F0F0)
          : Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text('Admin DashBoard',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
          height: 100.h,
          width: 100.w,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      return const CircularProgressIndicator();
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
                Divider(),
                FutureBuilder<QuerySnapshot>(
                  future: services.users
                      .where('type', isEqualTo: 'rider').get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Some things wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return InkWell(
                      onTap: (){

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
                Divider(),
                FutureBuilder<QuerySnapshot>(
                  future: services.users
                      .where('type', isEqualTo: 'user').get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Some things wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
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
              ],
            ),
          )
      ),


    );
  }
}
