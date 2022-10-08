import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Model/product_model.dart';


class ProductProvider with ChangeNotifier{

  ProductModel? productModel;

  List<ProductModel>search=[];

  productModels(QueryDocumentSnapshot element){
    productModel = ProductModel(
      productUrl: element.get('itemImage'),
      productName: element.get('itemName'),
      productPrice: element.get('price'),
      productId: element.get('itemId'),
    );
    search.add(productModel!);
  }


  ///////////////herbsProduct///////////////////////
  List<ProductModel> itemList =[];



  fetchItemData() async{

    List<ProductModel> newList =[];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("items").get();
    for (var element in snapshot.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    itemList = newList;
    notifyListeners();
  }


  List<ProductModel> get itemDataList{
    return itemList;
  }


  //////////////fresh product///////////////////////

  // List<ProductModel> freshProductList =[];
  //
  //
  //
  // fetchFreshProductData() async{
  //
  //   List<ProductModel> newList =[];
  //
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("FreshProduct").get();
  //   snapshot.docs.forEach((element) {
  //     productModels(element);
  //     newList.add(productModel);
  //   }
  //   );
  //   freshProductList = newList;
  //   notifyListeners();
  // }
  //
  //
  // List<ProductModel> get getFreshProductDataList{
  //   return freshProductList;
  // }
  //
  // ////////////////Root Product///////////////////////
  //
  //
  // List<ProductModel> rootProductList = [];
  //
  // fetchRootProductData() async{
  //   List<ProductModel> newList =[];
  //
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('RootProduct').get();
  //   snapshot.docs.forEach((element) {
  //     productModels(element);
  //     newList.add(productModel);
  //   });
  //   rootProductList = newList;
  //   notifyListeners();
  //
  // }
  // List<ProductModel> get getRootProductDataList{
  //   return rootProductList;
  // }
  //
  //
  // /////////////search return////////////////////
  //
  // List<ProductModel> get getAllProductSearch{
  //   return search;
  // }
}