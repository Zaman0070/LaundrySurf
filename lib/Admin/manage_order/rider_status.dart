import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/Admin/assign_to_rider.dart';
import 'package:laundry_app/Admin/manage_order/order_details.dart';
import 'package:laundry_app/Model/order_model.dart';
import 'package:laundry_app/provider/order_provider.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RiderStatus extends StatefulWidget {
  int? index;
   RiderStatus({Key? key,required this.index}) : super(key: key);

  @override
  State<RiderStatus> createState() => _RiderStatusState();
}

class _RiderStatusState extends State<RiderStatus>with TickerProviderStateMixin {





  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {


    OrderProvider orderProvider = Provider.of<OrderProvider>(context,listen: false);
    var orderData = orderProvider.orderData;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(widget.index==0?'Rider confirmed to pick':widget.index==1?"List of Rider pick order":widget.index==2?'Rider confirmed to Deliver':"All Delivered Order",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: services.order.where('orderStatus',isEqualTo: widget.index==0?'ConfirmedForPick':widget.index==1?'RiderPickOrder':widget.index==2?'ConfirmedDeliver':'Delivered').get(),
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
                  onTap: (){
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 16.h,
                      decoration: BoxDecoration(
                        color:  Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(0.2.h),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(widget.index==0?'assets/icons/clock.png':widget.index==1?'assets/icons/hand.png':'assets/icons/click.png',height: 4.h,),
                                SizedBox(width: 3.w,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    SizedBox(height: 1.h,),
                                    Row(
                                      children:  [
                                        Text("Order # ${data['orderNumber'] } ",style:  TextStyle(fontWeight: FontWeight.w600,fontSize: 14.sp),),
                                      ],
                                    ),
                                    SizedBox(height: 0.5.h,),
                                    Row(
                                      children:  [
                                        Text(data['pickTimeFrom'],style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),),
                                        SizedBox(width: 18.w,),
                                        Text(data['deliverTimeFrom'],style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 12.sp),)
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
                            SizedBox(height: 1.h,),
                            Text('      ${data['description']}',maxLines: 2,overflow: TextOverflow.ellipsis,)
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
