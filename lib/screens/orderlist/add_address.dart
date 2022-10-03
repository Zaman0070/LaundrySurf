import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(icon:const Icon(Icons.arrow_back,color: Colors.black,),onPressed: ()=>Navigator.pop(context),),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
                height: 4.h,
                width: 4.h,
                child: Image.asset('assets/icons/page.png',color: Colors.grey.shade700,)),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 14.h,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Image.asset('assets/icons/address.png',height: 2.h,),
                      Image.asset('assets/icons/dot.png',height: 5.h,),
                      Image.asset('assets/icons/location.png',height: 2.5.h,),
                    ],
                  ),
                ),
                Container(
                  height: 17.h,
                  width: 75.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 1.h,),
                      Text('CT7B The Sparks, KDT Duong Noi, Str. \nHa Dong, Ha Noi',style: TextStyle(color: Colors.grey.shade700,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 2,),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Divider(),
                      ),
                      SizedBox(height: 1.h,),
                      Text('CT7B The Sparks, KDT Duong Noi, Str. \nHa Dong, Ha Noi',style: TextStyle(color: Colors.grey.shade700,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 2,),

                    ],
                  ),
                ),

              ],
            ),
          ),
          Container(
            height: 8.h,
            width: 100.w,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 3.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                      height: 5.h,
                      width: 40.w,
                     decoration: BoxDecoration(
                       border: Border.all(color:index==0? const Color(0xff27C1F9) :Colors.grey.shade500),
                       borderRadius: BorderRadius.circular(6),
                     ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Image.asset('assets/icons/home.png',height: 3.h,color: index==0? const Color(0xff27C1F9):Colors.grey.shade500,),
                            const Text('Home'),
                            Image.asset('assets/icons/ok.png',height: 3.h,color: index==0? const Color(0xff27C1F9): Theme.of(context).scaffoldBackgroundColor,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                      height: 5.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border.all(color:index==1? const Color(0xff27C1F9) :Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Image.asset('assets/icons/work.png',height: 3.h,color: index==1? const Color(0xff27C1F9):Colors.grey.shade500,),
                            const Text('Work'),
                            Image.asset('assets/icons/ok.png',height: 3.h,color: index==1? const Color(0xff27C1F9): Theme.of(context).scaffoldBackgroundColor,),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: 66.h,
                width: 100.w,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),

              ),
              Positioned(
                right: 1.w,
                left: 1.w,
                bottom: 15.h,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 15),
                  child: InkWell(
                    onTap: ()=>Navigator.pop(context),
                    child: Container(
                      height: 5.5.h,
                      width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xff27C1F9)
                    ),
                      child:const Center(
                        child: Text('Done',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
