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
    return Container(
      height: 6.h,
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const CustomGoogleMap()));
                },
                child: Row(
                  children: [
                    Image.asset('assets/icons/location.png',height: 2.5.h,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' Pickup Address',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 15.sp),),
                        Text(' Your Current Location',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 12.sp),),
                      ],
                    ),
                  ],
                ),
            ),
            Text('Change',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 15.sp),),
          ],
        ),
      ),
    );
  }
}
