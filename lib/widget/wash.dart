import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/provider/cart_provider.dart';
import 'package:laundry_app/screens/orderlist/shedule_pickup.dart';
import 'package:laundry_app/screens/orderlist/widget/single_product.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/product_provider.dart';

class Wash extends StatefulWidget {

  const Wash({Key? key}) : super(key: key);

  @override
  State<Wash> createState() => _WashState();
}

class _WashState extends State<Wash> {
  final List<String> _locations = ['Men', 'Women', 'Child',]; // Option 2
  String? _selectedLocation;
  int itemCount = 0;



  Widget _buildItemList(context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context,listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: productProvider.itemDataList.map((itemData) {
              return  SingleProduct(
                productUrl:itemData.productUrl,
                productName:itemData.productName,
                productPrice: itemData.productPrice,
                productId: itemData.productId,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    ProductProvider initProductProvider =  Provider.of(context,listen: false );
    initProductProvider.fetchItemData();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getReviewCartDta();
    return Scaffold(
      bottomNavigationBar: Container(
        height: 18.h,
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(offset: const Offset(3, 3),blurRadius: 6,spreadRadius: 2,color: Colors.grey.shade400)
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
                        child: Image.asset('assets/wash/total.png',height: 3.h,color: const Color(0xff27C1F9),),
                      ),
                      SizedBox(width: 3.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),),
                          Text('${cartProvider.getTotalItem()} items',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Cost',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),),
                      Text('\$ ${cartProvider.getTotalPrice()}',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: const Color(0xff27C1F9)),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> SchedulePickUp(orderFor: 'Wash',)));
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
            _buildItemList(context),
          ],
        ),
      ),
    );
  }
}

// Padding(
//   padding: const EdgeInsets.only(top: 15.0),
//   child: SizedBox(
//     height: 3.5.h,
//     child: DropdownButton(
//       iconSize: 20,
//       hint:  Text('Men',style: TextStyle(fontSize: 10.sp),), // Not necessary for Option 1
//       value: _selectedLocation,
//       onChanged: (newValue) {
//         setState(() {
//           _selectedLocation = newValue.toString();
//         });
//       },
//       items: _locations.map((location) {
//         return DropdownMenuItem(
//           value: location,
//           child:  Text(location),
//         );
//       }).toList(),
//     ),
//   ),
// ),
