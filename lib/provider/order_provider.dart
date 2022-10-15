import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:laundry_app/Model/order_model.dart';
import 'package:laundry_app/services/firbaseservice.dart';
import 'package:location/location.dart';

import '../Model/cart_Model.dart';


class OrderProvider with ChangeNotifier {
  FirebaseServices services = FirebaseServices();
  DocumentSnapshot? orderData;
  QuerySnapshot ? ordersData;

  getOrderDetails(details) {
    orderData = details;
    notifyListeners();
  }
  getAllOrderDetails(details) {
    ordersData = details;
    notifyListeners();
  }

  List<String> urlList = [];
  getImage( url) {
    urlList.add(url);
    notifyListeners();
  }

  CollectionReference order = FirebaseFirestore.instance.collection('Order');
  int random1 = Random().nextInt(99999) ;


  LocationData? setLocation;
  void addOrderData({
    String? orderId,
    String? orderName,
    List<String>? orderUrl,
    String? orderQuantity,
    String? pickupDate,
    String? pickTime,
    String? deliverDate,
    String? deliverTime,
    String? orderFor,
    String? orderStatus,
    String? orderPlacerId,
    int? orderTime,
    int? price,
    String? description,

  }) async {

    await services.order.doc(orderId)
        .set({
      'orderId': order.doc(orderId),
      'orderName': orderName,
      'orderUrl': orderUrl,
      'orderQuantity': orderQuantity,
      'pickupDate':pickupDate,
      'pickTime':pickTime,
      'deliverDate':deliverDate,
      'deliverTime':deliverTime,
      'orderFor':orderFor,
      'latitude':setLocation!.latitude,
      'longitude':setLocation!.longitude,
      'orderStatus':orderStatus,
      'orderPlacerId':orderPlacerId,
      'orderTime':orderTime,
      'price':'',
      'riderAssign':'',
      'orderNumber':random1.toString(),
      "description":description,
    });
  }

  void updateOrderData({
    String? orderId,
    String? orderName,
    List<dynamic>? orderUrl,
    String? orderQuantity,
    String? pickupDate,
    String? pickTime,
    String? deliverDate,
    String? deliverTime,
    String? orderFor,
    String? orderStatus,
    String? orderPlacerId,
    int? orderTime,
    String? price,

  }) async {
    await FirebaseFirestore.instance
        .collection('Order').doc(orderId)
        .update({
      'orderId': order.doc(orderId),
      'orderName': orderName,
      'orderUrl': orderUrl,
      'orderQuantity': orderQuantity,
      'pickupDate':pickupDate,
      'pickTime':pickTime,
      'deliverDate':deliverDate,
      'deliverTime':deliverTime,
      'orderFor':orderFor,
      'latitude':setLocation!.latitude,
      'longitude':setLocation!.longitude,
      'orderStatus':orderStatus,
      'orderPlacerId':orderPlacerId,
      'orderTime':orderTime,
      'price':'',
      'riderAssign':'',
    });
  }





  List<OrderModel> orderDataList = [];
  void getOrderDta() async{
    List<OrderModel> newList = [];

    QuerySnapshot reviewCartValue= await FirebaseFirestore.instance.collection('Order').get();
    for (var element in reviewCartValue.docs) {
      OrderModel orderModel = OrderModel(
        orderId: element.get('orderId'),
        orderName: element.get('orderName'),
        orderUrl: element.get('orderUrl'),
        orderQuantity: element.get('orderQuantity'),
        orderPrice: element.get('price'),
        pickupDate:  element.get('pickupDate'),
          pickTime:  element.get('pickTime'),
      deliverDate:  element.get('deliverDate'),
      deliverTime:  element.get('deliverTime'),
        orderFor: element.get('orderFor'),
        orderStatus: element.get('orderStatus')
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



  //////////////////// \review cart del ///////////////////

  reviewCartDataDelete(orderId){
    FirebaseFirestore.instance.collection('Order').doc(orderId).delete();
    notifyListeners();
  }




}
