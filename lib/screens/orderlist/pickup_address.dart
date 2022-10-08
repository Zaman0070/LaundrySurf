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
          height: 8.h,
          width: 100.w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Row(
            children: [
              Image.asset('assets/icons/location.png',height: 3.h,),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const CustomGoogleMap()));
                  },
                  child: Text('Pickup Address',style: TextStyle(color: const Color(0xff381568),fontWeight: FontWeight.w500,fontSize: 15.sp),)),
            ],
          ),
        ),
      ],
    );
  }
}
