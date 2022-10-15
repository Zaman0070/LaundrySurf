import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:laundry_app/rider/rider_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/order_provider.dart';
import 'package:geocoding/geocoding.dart' as geo;

class PickOrderDetails extends StatefulWidget {
  String? address;
  int? index;
   PickOrderDetails({Key? key,required this.address,required this.index}) : super(key: key);


  @override
  State<PickOrderDetails> createState() => _PickOrderDetailsState();
}

class _PickOrderDetailsState extends State<PickOrderDetails> {

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    var data = orderProvider.orderData;

    return  Scaffold(
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
            Center(child: Text(widget.index==0?'Pick the order':"Deliver the order",style: TextStyle(color: const Color(0xff381568),fontSize: 15.sp,fontWeight: FontWeight.bold),)),
            SizedBox(height: 1.h,),
            Center(child: Text(widget.index==0?'After pickup the order so confirmed its.':'After Deliver the order so confirmed its.',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Colors.grey.shade500),)),
            SizedBox(height: 2.h,),
            Column(
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
                        Text('Order #${data!['orderNumber']}',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.bold,fontSize: 14.sp),),
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
                  color: Colors.white
              ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded,color: Colors.redAccent,),
                  Text(widget.address!,overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
            ),

            SizedBox(height: 1.h,),
            InkWell(
              onTap: () async {
                data.reference.update({
                  'orderName': data['orderName'],
                  'orderQuantity': data['orderQuantity'],
                  'orderUrl': data['orderUrl'],
                  'pickTime':  data['pickTime'],
                  'pickupDate': data['pickupDate'],
                  'deliverTime':  data['deliverTime'],
                  'deliverDate':  data['deliverDate'],
                  'orderFor':  data['orderFor'],
                  'orderStatus': widget.index==0?'RiderPickOrder & DeliverToLaundryHub':"Delivered",
                  'orderPlacerId': data['orderPlacerId'],
                  'orderTime': data['orderTime'],
                  'price': data['price'],
                  'riderAssign':data['riderAssign']
                });
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: Text(widget.index==0?'Order has been successfully Picked!':'Order has been successfully Delivered!'),
                  ),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const RiderScreen()));

              },
              child: Container(
                height: 5.5.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xff27C1F9)
                ),
                child: Center(
                  child: Text(widget.index==0?'Confirmed Pick':"Confirmed Delivered",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
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
