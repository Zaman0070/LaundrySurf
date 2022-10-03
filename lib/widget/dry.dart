import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/orderlist/shedule_pickup.dart';

class Dry extends StatefulWidget {
  const Dry({Key? key}) : super(key: key);

  @override
  State<Dry> createState() => _DryState();
}

class _DryState extends State<Dry> {
  final List<String> _locations = ['Men', 'Women', 'Child',]; // Option 2
  String? _selectedLocation;
  int itemCount = 0;

  Widget box({String? image,String? title,double? price}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        height: 10.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(image!,height: 4.5.h,),
                  SizedBox(width: 5.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.5.h,),
                      Text(title!),
                      SizedBox(height: 0.5.h,),
                      Text('\$${price}',style: TextStyle(color: const Color(0xff27C1F9),fontWeight: FontWeight.bold,fontSize: 11.sp),),
                    ],
                  ),
                  SizedBox(width: 1.5.w,),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                      height: 3.5.h,
                      child: DropdownButton(
                        iconSize: 20,
                        hint:  Text('Men',style: TextStyle(fontSize: 10.sp),), // Not necessary for Option 1
                        value: _selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue.toString();
                          });
                        },
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child:  Text(location),
                          );
                        }).toList(),
                      ),
                    ),
                  ),


                ],
              ),
              Container(
                height: 5.h,
                width: 25.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        setState(() {
                          itemCount--;
                        });
                      },
                      child: Container(
                        height: 4.h,
                        width: 4.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(offset: Offset(2, 3),blurRadius: 6,spreadRadius: 1,color: Colors.grey.shade400)
                            ]
                        ),
                        child: const Center(child: Icon(CupertinoIcons.minus)),

                      ),
                    ),
                    Text('${itemCount}',style: TextStyle(fontSize: 17.sp),),
                    InkWell(
                      onTap:(){
                        setState(() {
                          itemCount++;
                        });
                      },
                      child: Container(
                        height: 4.h,
                        width: 4.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(offset: Offset(2, 3),blurRadius: 6,spreadRadius: 1,color: Colors.grey.shade400)
                            ]
                        ),
                        child: const Center(child: Icon(CupertinoIcons.add )),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 15.h,
        decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(offset: Offset(3, 3),blurRadius: 6,spreadRadius: 2,color: Colors.grey.shade400)
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children:  [
                      CircleAvatar(
                        backgroundColor:const Color(0xff27C1F9).withOpacity(0.3),
                        radius: 23,
                        child: Image.asset('assets/wash/total.png',height: 3.5.h,color: const Color(0xff27C1F9),),
                      ),
                      SizedBox(width: 3.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),),
                          Text('${itemCount} items',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Cost',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),),
                      Text('\$${259}',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: const Color(0xff27C1F9)),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const SchedulePickUp()));
                },
                child: Container(
                  height: 5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff27C1F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:const Center(child: Text('Confirm Order',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            box(image: 'assets/wash/tshirt.png',title:'T-Shirt',price: 2 ),
            box(image: 'assets/wash/shirt.png',title: 'Shirt',price: 5),
            box(image: 'assets/wash/slevless.png',title: 'Sleeveless',price: 6),
            box(image: 'assets/wash/skirt.png',title: 'Skirt',price: 5),
            box(image: 'assets/wash/polo.png',title: 'Polo',price: 5),
            box(image: 'assets/wash/suit.png',title: 'Suit',price: 8),
            box(image: 'assets/wash/jean.png',title: 'Jeans',price: 3),
          ],
        ),
      ),
    );
  }
}
