import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/screens/home/main_screen.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:sizer/sizer.dart';

import '../orderlist/pickup_address.dart';





class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FirebaseServices services = FirebaseServices();


  Widget schedule(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Status',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 16.sp),),
                IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(CupertinoIcons.multiply,color: Colors.grey,)),
              ],
            ),
            const Divider(thickness: 1,),
            SizedBox(height: 2.h,),
            Container(
              height: 25.h,
              width: 100.w,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Image.asset('assets/icons/address.png',height: 1.5.h,),
                        Image.asset('assets/icons/dot.png',height: 4.5.h,),
                        Image.asset('assets/icons/pik.png',height: 1.5.h,),
                        Image.asset('assets/icons/dot.png',height: 4.5.h,),
                        Image.asset('assets/icons/clock.png',height: 1.5.h,),
                        Image.asset('assets/icons/dot.png',height: 5.5.h,),
                        Image.asset('assets/icons/hand.png',height: 1.5.h,),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                    width: 75.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1.h,),
                        InkWell(
                            onTap: (){
                            },
                            child: Text('Confirmed',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 13.sp),)),
                        SizedBox(height: 0.5.h,),
                        Text('Wed, 6 Jun 2019',style: TextStyle(color: Colors.grey,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 2,),
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Divider(),
                        ),
                        Text('Picked up',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 13.sp),),
                        SizedBox(height: 0.5.h,),
                        Text('7:00 AM, Wed, 6 Jun 2019',style: TextStyle(color: Colors.grey,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 2,),
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Divider(),
                        ),
                        Text('In Progress',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 13.sp),),
                        SizedBox(height: 0.5.h,),
                        Text('7:00 AM, Wed, 6 Jun 2019',style: TextStyle(color: Colors.grey,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 2,),
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Divider(),
                        ),
                        Text('Delivered',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 13.sp),),
                        SizedBox(height: 0.5.h,),
                        Text('7:00 AM, Wed, 6 Jun 2019',style: TextStyle(color: Colors.grey,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 2,),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            Image.asset('assets/images/truck.png',height: 16.h,),
            Center(child: Text('Thanks for choosing Us!',style: TextStyle(color: const Color(0xff381568),fontSize: 15.sp,fontWeight: FontWeight.bold),)),
            SizedBox(height: 1.h,),
            Center(child: Text('Your pickup has been confirmed',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Colors.grey.shade500),)),
            SizedBox(height: 2.h,),
            FutureBuilder<QuerySnapshot>(
              future: services.order.where('orderStatus',isEqualTo: 'acceptThis').where('orderPlacerId',isEqualTo: services.user!.uid)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Some things wronge');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
                      child: const Center(child: CircularProgressIndicator())
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data!.docs[index];
                      return   Column(
                        children: [
                          Container(
                            height: 35.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Order #${data['orderNumber']}',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                      Text(' (${data['orderQuantity']} ${data['orderName']})',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),),
                                    ],
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text('${data['pickupDate']}-  To  -${data['deliverDate']}',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),),
                                  const Divider(),
                                  Text(data['orderFor'],style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 13.sp),),
                                  SizedBox(height: 0.7.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(text:  TextSpan(text: '${data['orderQuantity']} x ${data['orderName']}  ',style: TextStyle(color: Colors.grey.shade900,fontSize: 11.sp),
                                      ),
                                      ),
                                      Text('\$${data['price']}',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                                    ],
                                  ),
                                  SizedBox(height: 0.7.h,),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Subtotal',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                                      Text('\$${data['price']}',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                                    ],
                                  ),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Text',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                                      Text('\0.00',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                                      Text('\$${data['price']}',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Container(
                            height: 8.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  Row(

                                    children: [
                                      Image.asset('assets/icons/ost.png',height: 2.h,),
                                      SizedBox(width: 2.w,),
                                      Text('Order Status',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                    ],
                                  ),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 0.5.h,
                                        backgroundColor: Colors.green,
                                      ),
                                      SizedBox(width: 4.w,),
                                      Text(data['orderStatus'],style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 13.sp),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          // InkWell(
                          //   onTap: () async {
                          //     data.reference.update({
                          //       'orderName': data['orderName'],
                          //       'orderQuantity': data['orderQuantity'],
                          //       'orderUrl': data['orderUrl'],
                          //       'pickTime':  data['pickTime'],
                          //       'pickupDate': data['pickupDate'],
                          //       'deliverTime':  data['deliverTime'],
                          //       'deliverDate':  data['deliverDate'],
                          //       'orderFor':  data['orderFor'],
                          //       'orderStatus': 'confirmed',
                          //       'orderPlacerId': data['orderPlacerId'],
                          //       'orderTime': data['orderTime'],
                          //       'price': data['price'],
                          //     });
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content: Text('Order has been successfully Placed !'),
                          //       ),
                          //     );
                          //     Navigator.pushReplacement(context,
                          //         MaterialPageRoute(builder: (_) => const MainScreen()));
                          //
                          //   },
                          //   child: Container(
                          //     height: 5.5.h,
                          //     width: 100.w,
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(6),
                          //         color: const Color(0xff27C1F9)
                          //     ),
                          //     child:const Center(
                          //       child: Text('Confirmed Order',style: TextStyle(color: Colors.white),),
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    });
              },
            ),

            // SizedBox(height: 1.h,),
            // Container(
            //   height: 10.5.h,
            //   width: 100.w,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey.shade300),
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //
            //           children: [
            //             Image.asset('assets/icons/pay.png',height: 2.h,),
            //             SizedBox(width: 2.w,),
            //             Text('Payment Method',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 14.sp),),
            //           ],
            //         ),
            //         SizedBox(height: 1.h,),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 20.0),
            //           child: Text('Visa/Master Card ***********1234',style: TextStyle(color: Colors.grey,fontSize: 10.sp),),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const PickUpAddress(),
            SizedBox(height: 1.h,),

            SizedBox(height: 4.h,),


          ],
        ),
      ),
    );
  }
}
