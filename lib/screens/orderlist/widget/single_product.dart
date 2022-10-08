import 'package:flutter/material.dart';
import 'package:laundry_app/screens/orderlist/widget/count.dart';
import 'package:sizer/sizer.dart';


class SingleProduct extends StatefulWidget {
  final String? productUrl;
  final String? productName;
  final int? productPrice;
  final String? productId;


  const SingleProduct({Key? key, this.productUrl,this.productName,this.productPrice,this.productId}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {

  var firstValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        height: 10.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
        ),
        child: ListTile(
          leading:  Image.network(widget.productUrl!,height: 4.5.h,),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.5.h,),
                      Text(widget.productName!),
                      SizedBox(height: 0.5.h,),
                      Text("\$${widget.productPrice}",style: TextStyle(color: const Color(0xff27C1F9),fontWeight: FontWeight.bold,fontSize: 11.sp),),
                    ],
                  ),

                ],
              ),

            ],
          ),
          trailing: Count(
            productId: widget.productId,
            productName: widget.productName,
            productUrl: widget.productUrl,
            productPrice: widget.productPrice,
          ),
        ),
      ),
    );
    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: 10),
    //         height: 250.0,
    //         width: 170.0,
    //         decoration: BoxDecoration(
    //           color: Color(0xffd9dad9),
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             GestureDetector(
    //               onTap:widget.onTap,
    //               child: Container(
    //                 height: 150,
    //                 padding: EdgeInsets.all(5),
    //                 width: double.infinity,
    //                 child: Image.network(
    //                   widget.productUrl,
    //                 ),
    //               ),
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(widget.productName,
    //                   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    //                 ),
    //                 Text(
    //                   '${widget.productPrice}\$/${unitData ?? firstValue}',
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.w200,
    //                     fontSize: 14,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 8,
    //                 ),
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     ProductUnit(
    //                       onTap: (){
    //
    //                         showModalBottomSheet(
    //                             context: context,
    //                             builder: (context) {
    //                               return Column(
    //                                 mainAxisSize: MainAxisSize.min,
    //                                 children:widget.productUnit.productUnit.map<Widget>((data){
    //                                   return Column(
    //                                     children: [
    //                                       Padding(
    //                                         padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    //                                         child: InkWell(
    //                                           onTap: ()async {
    //                                             setState(() {
    //                                               unitData = data;
    //                                             });
    //                                             Navigator.of(context).pop();
    //                                           },
    //                                           child: Text(data,
    //                                             style: TextStyle(
    //                                               fontSize: 18,
    //                                             ),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   );
    //                                 }).toList(),
    //
    //                               );
    //                             });
    //
    //                       },
    //                       title:unitData == null
    //                           ? firstValue
    //                           :unitData,
    //
    //                     ),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     Count(
    //                       productId: widget.productId,
    //                       productName: widget.productName,
    //                       productUrl: widget.productUrl,
    //                       productPrice: widget.productPrice,
    //                       productUnit: unitData == null
    //                           ? firstValue
    //                           :unitData,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// class SingleImage extends StatefulWidget {
//
//   String? productName;
//   String? image;
//   double? productPrice;
//   SingleImage({Key? key, required this.productName,required this.productPrice,required this.image}) : super(key: key);
//
//   @override
//   _SingleImageState createState() => _SingleImageState();
// }
//
// class _SingleImageState extends State<SingleImage> {
//   int itemCount = 0;
//
//
//   @override
//   Widget build(BuildContext context) {

//
//   }
// }
