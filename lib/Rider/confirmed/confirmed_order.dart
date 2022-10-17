import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/order_provider.dart';
import '../../services/firbaseservice.dart';
import 'confirmed_pick_order_details.dart';

class RiderConfirmedOrder extends StatefulWidget {
  int? index;
  RiderConfirmedOrder({Key? key,required this.index}) : super(key: key);

  @override
  State<RiderConfirmedOrder> createState() => _RiderConfirmedOrderState();
}

class _RiderConfirmedOrderState extends State<RiderConfirmedOrder> {
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title:  Text(widget.index==0?'Confirmed for pick Order':"Confirmed for deliver Order",style: TextStyle(color: Colors.black,fontSize: 18.sp),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: services.order.where('orderStatus',isEqualTo: widget.index == 0?'assignToRiderForPick':'assignToRiderForDeliver').where('riderAssign',isEqualTo: services.user!.uid)
            .orderBy('orderTime')
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Some things wrong');
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
                return InkWell(
                  onTap: ()async{

                    orderProvider.getOrderDetails(data);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> ConfirmPickOrderDetails(index: widget.index,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 10.5.h,
                      decoration: BoxDecoration(
                        color:  Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(0.2.h),
                        child:Row(
                          children: [
                            Image.asset('assets/icons/clock.png',height: 4.h,),
                            SizedBox(width: 3.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                SizedBox(height: 1.h,),
                                Row(
                                  children:  [
                                    Text("Order ${data['orderNumber'] } # ",style:  TextStyle(fontWeight: FontWeight.w600,fontSize: 14.sp),),
                                    Text(data['orderName'],style:  TextStyle(fontWeight: FontWeight.w600,fontSize: 14.sp),),
                                    SizedBox(width: 1.w,),
                                    Text("(${data['orderQuantity']}) items for ${data['orderFor']}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11.sp),),
                                  ],
                                ),
                                SizedBox(height: 0.5.h,),
                                Row(
                                  children:  [
                                    Text(data['pickTime'],style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),),
                                    SizedBox(width: 18.w,),
                                    Text(data['deliverTime'],style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),)
                                  ],
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 18.w),
                                  child: Image.asset('assets/icons/to.png',height: 0.9.h,),
                                ),
                                Row(
                                  children:  [
                                    Text(data['pickupDate'],style: TextStyle(color:  Colors.grey[700],fontSize: 12.sp),),
                                    SizedBox(width: 15.w,),
                                    Text(data['deliverDate'],style: TextStyle(color:  Colors.grey[700],fontSize: 12.sp),)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
