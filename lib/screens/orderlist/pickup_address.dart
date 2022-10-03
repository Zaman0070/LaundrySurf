import 'package:flutter/material.dart';
import 'package:laundry_app/screens/orderlist/add_address.dart';
import 'package:sizer/sizer.dart';

class PickUpAddress extends StatefulWidget {
  const PickUpAddress({Key? key}) : super(key: key);

  @override
  State<PickUpAddress> createState() => _PickUpAddressState();
}

class _PickUpAddressState extends State<PickUpAddress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h,),
        Text("Address",style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 16.sp),),
        SizedBox(height: 1.h,),
        Container(
          height: 20.h,
          width: 100.w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Image.asset('assets/icons/address.png',height: 2.5.h,),
                    Image.asset('assets/icons/dot.png',height: 10.h,),
                    Image.asset('assets/icons/location.png',height: 3.h,),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
                width: 75.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1.h,),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddAddress()));
                        },
                        child: Text('Pickup Address',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 15.sp),)),
                    SizedBox(height: 1.h,),
                    Text('CT7B The Sparks, KDT Duong Noi, Str. \nHa Dong, Ha Noi',style: TextStyle(color: Colors.grey,fontSize: 12.sp),overflow: TextOverflow.ellipsis,maxLines: 2,),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Divider(),
                    ),
                    Text('Delivery Address',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 15.sp),),
                    SizedBox(height: 1.h,),
                    Text('CT7B The Sparks, KDT Duong Noi, Str. \nHa Dong, Ha Noi',style: TextStyle(color: Colors.grey,fontSize: 12.sp),overflow: TextOverflow.ellipsis,maxLines: 2,),

                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h,)
      ],
    );
  }
}
