import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../provider/cart_provider.dart';

class Count extends StatefulWidget {

  String? productName;
  String? productUrl;
  String? productId;
  int? productPrice;
  Count({this.productName,this.productUrl,this.productId,this.productPrice});

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int itemCount = 0;
  bool isTrue = false;

  getAddANdQuantity(){
    FirebaseFirestore.instance.collection('Cart').doc(widget.productId)
        .get().then((value) {
      if(mounted){
        if(value.exists){
          setState(() {
            itemCount =value.get('cartQuantity');
          });
        }

      }
    } );
  }

  @override
  Widget build(BuildContext context) {
    getAddANdQuantity();
    CartProvider cartProvider = Provider.of(context);
    return  SizedBox(
      height: 5.h,
      width: 25.w,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){

               if(itemCount > 0){
                setState(() {
                  itemCount --;
                });
                cartProvider.updateCartData(
                  cartId: widget.productId,
                  cartName: widget.productName,
                  cartUrl: widget.productUrl,
                  cartPrice: widget.productPrice,
                  cartQuantity: itemCount,
                );
              }


            },

            child: Container(
              height: 4.h,
              width: 4.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(offset: const Offset(2, 3),blurRadius: 6,spreadRadius: 1,color: Colors.grey.shade400)
                  ]
              ),
              child: const Center(child: Icon(CupertinoIcons.minus)),

            ),
          ),
          Text('$itemCount',style: TextStyle(fontSize: 17.sp),),
          InkWell(
            onTap: (){
              setState(() {
                itemCount ++;
              });
                cartProvider.addCartData(
                  cartId: widget.productId,
                  cartName: widget.productName,
                  cartUrl: widget.productUrl,
                  cartPrice: widget.productPrice,
                  cartQuantity: itemCount,
                );


                cartProvider.updateCartData(
                cartId: widget.productId,
                cartName: widget.productName,
                cartUrl: widget.productUrl,
                cartPrice: widget.productPrice,
                cartQuantity: itemCount,
              );

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
      )
    );
  }
}
