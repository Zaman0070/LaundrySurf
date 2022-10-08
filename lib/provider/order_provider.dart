import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry_app/Model/order_model.dart';
import 'package:location/location.dart';

import '../Model/cart_Model.dart';


class OrderProvider with ChangeNotifier {
  LocationData? setLocation;
  void addOrderData({
    String? orderId,
    String? orderName,
    String? orderUrl,
    int? orderPrice,
    int? orderQuantity,
    String? pickupDate,
    String? pickTime,
    String? deliverDate,
    String? deliverTime,
    String? orderFor,

  }) async {
    await FirebaseFirestore.instance
        .collection('Order').doc(orderId)
        .set({
      'orderId': orderId,
      'orderName': orderName,
      'orderUrl': orderUrl,
      'orderPrice': orderPrice,
      'orderQuantity': orderQuantity,
      'pickupDate':pickupDate,
      'pickTime':pickTime,
      'deliverDate':deliverDate,
      'deliverTime':deliverTime,
      'orderFor':orderFor,
      'latitude':setLocation!.latitude,
      'longitude':setLocation!.longitude
    });
  }





  List<OrderModel> orderDataList = [];
  void getOrderDta() async{
    List<OrderModel> newList = [];

    QuerySnapshot reviewCartValue= await FirebaseFirestore.instance.collection('Order').get();
    for (var element in reviewCartValue.docs) {
      OrderModel orderModel = OrderModel(
        orderId: element.get('cartId'),
        orderName: element.get('cartName'),
        orderUrl: element.get('cartUrl'),
        orderQuantity: element.get('cartQuantity'),
        orderPrice: element.get('cartPrice'),
        pickupDate:  element.get('pickupDate'),
          pickTime:  element.get('pickTime'),
      deliverDate:  element.get('deliverDate'),
      deliverTime:  element.get('deliverTime'),
        orderFor: element.get('orderFor'),
      );
      newList.add(orderModel);
    }
    orderDataList =newList;
    notifyListeners();
  }

  List<OrderModel> get  getOrderDataList {
    return  orderDataList;
  }
//////////// Total Price//////////////////////


  // getTotalPrice(){
  //   double total =0.0;
  //   orderDataList.forEach((element) {
  //     total += element.cartPrice! * element.cartQuantity!;
  //   });
  //   return total;
  // }
  // getTotalItem(){
  //   int total =0;
  //   reviewCartDataList.forEach((element) {
  //     total += element.cartQuantity!;
  //   });
  //   return total;
  // }

  //////////////////// \review cart del ///////////////////

  reviewCartDataDelete(orderId){
    FirebaseFirestore.instance.collection('Order').doc(orderId).delete();
    notifyListeners();
  }
}
