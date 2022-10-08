import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/orderlist/pickup_address.dart';




class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {


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
            Container(
              height: 51.h,
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
                        Text('Order #123',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 14.sp),),
                        Text(' (2 bags)',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Text('11:35 AM,Thu, 15 Jun 2019',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),),
                    const Divider(),
                    Text('Wash & Fold',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 13.sp),),
                    SizedBox(height: 0.7.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text:  TextSpan(text: '2 x Tshirt  ',style: TextStyle(color: Colors.grey.shade900,fontSize: 11.sp),
                          children: [
                            TextSpan(text: '(Men)',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),)
                          ]
                        ),
                        ),
                        Text('\$6',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                      ],
                    ),
                    SizedBox(height: 0.7.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text:  TextSpan(text: '3 x Tshirt  ',style: TextStyle(color: Colors.grey.shade900,fontSize: 11.sp),
                            children: [
                              TextSpan(text: '(Men)',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),)
                            ]
                        ),
                        ),
                        Text('\$9',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 13.sp),),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Text('Wash & Iron',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 13.sp),),
                    SizedBox(height: 0.7.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text:  TextSpan(text: '2 x Tshirt  ',style: TextStyle(color: Colors.grey.shade900,fontSize: 11.sp),
                            children: [
                              TextSpan(text: '(Men)',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),)
                            ]
                        ),
                        ),
                        Text('\$6',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                      ],
                    ),
                    SizedBox(height: 0.7.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text:  TextSpan(text: '3 x Tshirt  ',style: TextStyle(color: Colors.grey.shade900,fontSize: 11.sp),
                            children: [
                              TextSpan(text: '(Men)',style: TextStyle(color: Colors.grey.shade600,fontSize: 10.sp),)
                            ]
                        ),
                        ),
                        Text('\$9',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                        Text('\$223.00',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Text',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                        Text('\$10.00',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                      ],
                    ),
                   const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 12.sp),),
                        Text('\$233.00',style: TextStyle(color:Colors.red.shade800,fontWeight: FontWeight.bold,fontSize: 14.sp),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 12.h,
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
                        SizedBox(width: 38.w,),
                        Text('View all',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400,fontSize: 13.sp),),

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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Delivered',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w400,fontSize: 13.sp),),
                            SizedBox(height: 0.5.h,),
                            Text('7:00 AM, Wed, 6 Jun 2019',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 11.sp),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 10.5.h,
              width: 100.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(

                      children: [
                        Image.asset('assets/icons/pay.png',height: 2.h,),
                        SizedBox(width: 2.w,),
                        Text('Payment Method',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 14.sp),),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text('Visa/Master Card ***********1234',style: TextStyle(color: Colors.grey,fontSize: 10.sp),),
                    ),
                  ],
                ),
              ),
            ),
            const PickUpAddress(),
            SizedBox(height: 1.h,),
            InkWell(
              onTap: (){
                showFlexibleBottomSheet(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minHeight: 0,
                    isCollapsible: true,
                    initHeight: 0.8,
                    maxHeight: 0.8,
                    context: context,
                    builder: schedule,
                    isExpand: false,
                    isDismissible: true
                );
              },
              child: Container(
                height: 5.5.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xff27C1F9)
                ),
                child:const Center(
                  child: Text('Schedule a laundry',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            SizedBox(height: 4.h,),


          ],
        ),
      ),
    );
  }
}
