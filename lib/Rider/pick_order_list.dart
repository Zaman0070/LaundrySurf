import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:laundry_app/Rider/pick_order_details.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/order_provider.dart';
import '../services/firbaseservice.dart';

class PickOrderList extends StatefulWidget {
  int? index;
   PickOrderList({Key? key,required this.index}) : super(key: key);

  @override
  State<PickOrderList> createState() => _PickOrderListState();
}

class _PickOrderListState extends State<PickOrderList> {
  String address='';
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title:  Text(widget.index==0?'Pickup Order List':"Deliver Order List",style: TextStyle(color: Colors.black,fontSize: 18.sp),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:  FutureBuilder<QuerySnapshot>(
        future: services.order.where('orderStatus',isEqualTo: widget.index == 0?'ConfirmedForPick':'ConfirmedDeliver').where('riderAssign',isEqualTo: services.user!.uid)
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
                    List<geo.Placemark> placemarks =  await geo.placemarkFromCoordinates(data['latitude'], data['longitude']);
                    setState(() {
                      geo.Placemark  place= placemarks[0];
                      address = '${place.street},${place.locality},${place.subLocality},${place.country}';

                    });
                    orderProvider.getOrderDetails(data);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> PickOrderDetails(address: address,index: widget.index,)));
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
