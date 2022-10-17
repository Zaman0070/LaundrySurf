import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: FutureBuilder<DocumentSnapshot>(
            future: services.getUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.data == null) {
                return Container();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ));
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 2.6.h,
                        child: CircleAvatar(
                          radius: 2.5.h,
                          backgroundImage: NetworkImage(
                            snapshot.data!['url'],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!['name'],
                            style: TextStyle(
                                color: const Color(0xff381568),
                                fontSize: 15.sp),
                          ),
                          Text(
                            'Gold member ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/icons/bell.png',
                        height: 3.5.h,
                      ))
                ],
              );
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).splashColor,
              ),
              height: 50.0,
              child: const TextField(
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Search services',
                  //  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Services',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xff381568),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              height: 13.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset('assets/images/wash.png'),
                    Image.asset('assets/images/fold.png'),
                    Image.asset('assets/images/iron.png'),
                    Image.asset('assets/images/dry.png'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Image.asset('assets/images/banner.png'),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Last Order',
              style: TextStyle(color: const Color(0xff381568), fontSize: 15.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            FutureBuilder<QuerySnapshot>(
              future: services.order
                  .where('orderPlacerId', isEqualTo: services.user!.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                return ListView.builder(
                    physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 22.3.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0.2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13.0, left: 8),
                                      child: Image.asset(
                                        data['orderStatus'] == 'forUpdate'
                                            ? 'assets/icons/clock.png'
                                            : data['orderStatus'] == 'acceptThis'
                                                ? 'assets/icons/hand.png'
                                                : 'assets/icons/click.png',
                                        height: 4.h,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Order # ${data['orderNumber']} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '(${data['orderQuantity']} ${data['orderFor']})',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  data['pickTime'],
                                                  style: TextStyle(
                                                      color:
                                                          const Color(0xff381568),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12.sp),
                                                ),
                                                SizedBox(
                                                  width: 18.w,
                                                ),
                                                Text(
                                                  data['deliverTime'],
                                                  style: TextStyle(
                                                      color:
                                                          const Color(0xff381568),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12.sp),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20.w),
                                              child: Image.asset(
                                                'assets/icons/to.png',
                                                height: 0.9.h,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  data['pickupDate'],
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 12.sp),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  data['deliverDate'],
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 12.sp),
                                                )
                                              ],
                                            ),
                                            // Text(data['orderStatus']=='forUpdate'?"Under Review":data['orderStatus']=='acceptThis'?"Order Accepted")
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        data['orderStatus'] == 'forUpdate'
                                            ? ''
                                            : data['orderStatus'] == 'acceptThis'
                                                ? "\$${data['price']}"
                                                : '\$${data['price']}',
                                        style: TextStyle(
                                            color: const Color(0xff27C1F9),
                                            fontSize: 15.sp),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 0.5.h,),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Order Status',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'assets/icons/address.png',
                                            height: 1.5.h,
                                          ),
                                          SizedBox(width: 1.w,),
                                          Image.asset(
                                            'assets/icons/dot.png',color:data['orderStatus']=='acceptThis'? Colors.black:Colors.grey,
                                            height: 0.17.h,
                                          ),
                                          SizedBox(width: 1.w,),
                                          Image.asset(
                                            'assets/icons/pik.png',
                                            height: 1.5.h,
                                            color: data['orderStatus']=='RiderPickOrder & DeliverToLaundryHub'?Colors.red:Colors.grey,
                                          ),
                                          SizedBox(width: 1.w,),
                                          Image.asset(
                                            'assets/icons/dot.png',
                                            height: 0.17.h,
                                            color: data['orderStatus']=='RiderPickOrder & DeliverToLaundryHub'?Colors.black:Colors.grey,
                                          ),
                                          SizedBox(width: 1.w,),
                                          Image.asset(
                                            'assets/icons/clock.png',
                                            height: 1.5.h,
                                            color: data['orderStatus']=='RiderPickOrder & DeliverToLaundryHub'?Colors.red:Colors.grey,
                                          ),
                                          SizedBox(width: 1.w,),
                                          Image.asset(
                                            'assets/icons/dot.png',
                                            height: 0.17.h,
                                            color: data['orderStatus']=='RiderPickOrder & DeliverToLaundryHub'?Colors.black:Colors.grey,
                                          ),
                                          SizedBox(width: 1.w,),
                                          Image.asset(
                                            'assets/icons/hand.png',
                                            height: 1.5.h,
                                            color: data['orderStatus']=='Delivered'?const Color(0xff27C1F9):Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Confirmed',
                                            style: TextStyle(
                                                color: const Color(0xff381568),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),
                                          SizedBox(width: 3.w,),
                                          Text(
                                            'Picked up',
                                            style: TextStyle(
                                                color: data['orderStatus']=='RiderPickOrder & DeliverToLaundryHub'?const Color(0xff381568):Colors.grey,
                                                // color: const Color(0xff381568),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(right: 8.0),
                                            child: Divider(),
                                          ),
                                          Text(
                                            'In Progress',
                                            style: TextStyle(
                                                color: data['orderStatus']=='RiderPickOrder & DeliverToLaundryHub'?const Color(0xff381568):Colors.grey,
                                                //color: const Color(0xff381568),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),

                                          const Padding(
                                            padding: EdgeInsets.only(right: 8.0),
                                            child: Divider(),
                                          ),
                                          Text(
                                            'Delivered',
                                            style: TextStyle(
                                                color: data['orderStatus']=='Delivered'?const Color(0xff381568):Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 8.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: Column(
            //     children: [
            //       Container(
            //         height: 10.5.h,
            //        decoration: BoxDecoration(
            //          color:  Colors.grey[200],
            //          borderRadius: BorderRadius.circular(10),
            //        ),
            //         child: Padding(
            //           padding:  EdgeInsets.all(0.2.h),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Image.asset('assets/icons/clock.png',height: 4.h,),
            //                   SizedBox(width: 3.w,),
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children:  [
            //                       Row(
            //                         children:  [
            //                           const Text('Order # 123',style: TextStyle(fontWeight: FontWeight.w500),),
            //                           Text(' (2 bags)',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11.sp),),
            //                         ],
            //                       ),
            //                       SizedBox(height: 0.5.h,),
            //                       Row(
            //                         children:  [
            //                            Text('10:00',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),),
            //                           SizedBox(width: 18.w,),
            //                             Text('20:00',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),)
            //                         ],
            //                       ),
            //                       Padding(
            //                         padding:  EdgeInsets.only(left: 10.w),
            //                         child: Image.asset('assets/icons/to.png',height: 0.9.h,),
            //                       ),
            //                       Row(
            //                         children:  [
            //                           Text('Thu, 1 Apr',style: TextStyle(color:  Colors.grey[700],fontSize: 12.sp),),
            //                           SizedBox(width: 15.w,),
            //                           Text('Thu, 1 Apr',style: TextStyle(color:  Colors.grey[700],fontSize: 12.sp),)
            //                         ],
            //                       ),
            //
            //
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //                Text("\$${'60.23'}",style: TextStyle(color:const Color(0xff27C1F9),fontSize: 15.sp),)
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 1.h,),
            //       Container(
            //         height: 10.5.h,
            //         decoration: BoxDecoration(
            //           color:  Colors.grey[200],
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Padding(
            //           padding:  EdgeInsets.all(0.2.h),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Image.asset('assets/icons/hand.png',height: 4.h,),
            //                   SizedBox(width: 3.w,),
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children:  [
            //                       Row(
            //                         children:  [
            //                           const Text('Order # 123',style: TextStyle(fontWeight: FontWeight.w500),),
            //                           Text(' (2 bags)',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11.sp),),
            //                         ],
            //                       ),
            //                       SizedBox(height: 0.5.h,),
            //                       Row(
            //                         children:  [
            //                            Text('10:00',style: TextStyle(color:  const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),),
            //                           SizedBox(width: 18.w,),
            //                             Text('20:00',style: TextStyle(color:const  Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),)
            //                         ],
            //                       ),
            //                       Padding(
            //                         padding:  EdgeInsets.only(left: 10.w),
            //                         child: Image.asset('assets/icons/to.png',height: 0.9.h,),
            //                       ),
            //                       Row(
            //                         children:  [
            //                           Text('Thu, 1 Apr',style: TextStyle(color:  Colors.grey[700],fontSize: 12.sp),),
            //                           SizedBox(width: 15.w,),
            //                           Text('Thu, 1 Apr',style: TextStyle(color:  Colors.grey[700],fontSize: 12.sp),)
            //                         ],
            //                       ),
            //
            //
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               Text("\$${'60.23'}",style: TextStyle(color: const Color(0xff27C1F9),fontSize: 15.sp),)
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 1.h,),
            //       Container(
            //         height: 10.5.h,
            //         decoration: BoxDecoration(
            //           color:  Colors.grey[200],
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Padding(
            //           padding:  EdgeInsets.all(0.2.h),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Image.asset('assets/icons/click.png',height: 4.h,),
            //                   SizedBox(width: 3.w,),
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children:  [
            //                       Row(
            //                         children:  [
            //                           const Text('Order # 123',style: TextStyle(fontWeight: FontWeight.w500),),
            //                           Text(' (2 bags)',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11.sp),),
            //                         ],
            //                       ),
            //                       SizedBox(height: 0.5.h,),
            //                       Row(
            //                         children:  [
            //                            Text('10:00',style: TextStyle(color:  const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),),
            //                           SizedBox(width: 18.w,),
            //                             Text('20:00',style: TextStyle(color:const  Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),)
            //                         ],
            //                       ),
            //                       Padding(
            //                         padding:  EdgeInsets.only(left: 10.w),
            //                         child: Image.asset('assets/icons/to.png',height: 0.9.h,),
            //                       ),
            //                       Row(
            //                         children:  [
            //                           Text('Thu, 1 Apr',style: TextStyle(color:  Colors.grey[700],fontSize: 12.sp),),
            //                           SizedBox(width: 15.w,),
            //                           Text('Thu, 1 Apr',style: TextStyle(color:  Colors.grey[700],fontSize: 12.sp),)
            //                         ],
            //                       ),
            //
            //
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               Text("\$${'60.23'}",style: TextStyle(color: Color(0xff27C1F9),fontSize: 15.sp),)
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
