import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Model/cart_Model.dart';


class CartProvider with ChangeNotifier {
  void addCartData({
    String? cartId,
    String? cartName,
    String? cartUrl,
    int? cartPrice,
    int? cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection('Cart').doc(cartId)
        .set({
      'cartId': cartId,
      'cartName': cartName,
      'cartUrl': cartUrl,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
    });
  }




  void updateCartData({
    String? cartId,
    String? cartName,
    String? cartUrl,
    int? cartPrice,
    int? cartQuantity,

  }) async {
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(cartId)
        .update({
      'cartId': cartId,
      'cartName': cartName,
      'cartUrl': cartUrl,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,

    });
  }





  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartDta() async{
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCartValue= await FirebaseFirestore.instance.collection('Cart').get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.get('cartId'),
        cartName: element.get('cartName'),
        cartUrl: element.get('cartUrl'),
        cartQuantity: element.get('cartQuantity'),
        cartPrice: element.get('cartPrice'),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList =newList;
    notifyListeners();
  }

  List<ReviewCartModel> get  getReviewCartDataList {
    return  reviewCartDataList;
  }
//////////// Total Price//////////////////////


  getTotalPrice(){
    double total =0.0;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice! * element.cartQuantity!;
    });
    return total;
  }
  getOrderPrice(){
    int total =0;
    for (var element in reviewCartDataList) {
      total += element.cartPrice! * element.cartQuantity!;
    }
    return total;
  }
  getOrderNameList(){
    String? name;
    for (var element in reviewCartDataList) {
      name = element.cartName!;
    }
    return name;
  }

  getTotalItem(){
    int total =0;
    reviewCartDataList.forEach((element) {
      total += element.cartQuantity!;
    });
    return total;
  }

  //////////////////// \review cart del ///////////////////

  reviewCartDataDelete(cartId){
    FirebaseFirestore.instance.collection('Cart').doc(cartId).delete();
    notifyListeners();
  }
  
  /// 

  ReviewCartModel? cartModel;

  List<ReviewCartModel>search=[];

  cartModelsName(QueryDocumentSnapshot element){
    cartModel = ReviewCartModel(
      cartUrl: element.get('itemImage'),
      cartName: element.get('itemName'),
      cartPrice: element.get('price'),
      cartId: element.get('itemId'),
      cartQuantity: element.get('cartQuantity')
    );
    search.add(cartModel!);
  }


  ///////////////herbsProduct///////////////////////
  List<ReviewCartModel> itemList =[];



  fetchCartData() async{
    List<ReviewCartModel> newList =[];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Cart").where('cartQuantity',isGreaterThan: 0).get();
    for (var element in snapshot.docs) {
      cartModelsName(element);
      newList.add(cartModel!);
    }
    itemList = newList;
    notifyListeners();
  }


  List<ReviewCartModel> get cartDataList{
    return itemList;
  }

}
