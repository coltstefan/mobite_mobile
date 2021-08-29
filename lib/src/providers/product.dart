import 'dart:async';

import 'package:delivery_app/src/helpers/product.dart';
import 'package:delivery_app/src/models/products.dart';
import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../helpers/restaurant.dart';

class ProductProvider with ChangeNotifier{

  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];
  List<ProductModel> productsCart = [];

  ProductProvider.initialize(){
   // _timer = new Timer(const Duration(milliseconds: 400), () {
      _loadProducts();
      search();
    } //);



  _loadProducts() async {
    await _productServices.getProducts().then((value) {
      products = value;
      print(products[1].featured);
      notifyListeners();
    });
  }

   Future loadProductsByCategory({String categoryName}) async{

    await _productServices.getProductsofCategory(category: categoryName).then((value){
      productsByCategory = value;
      notifyListeners();
    });
  }

  Future loadProductsByRestaurant({int restaurantId}) async{

    await _productServices.getProductsofRestaurnts(id: restaurantId).then((value){
      productsByRestaurant = value;
      notifyListeners();
    });
  }

  Future loadProductsByCart() async{

    await _productServices.getProductsofCart().then((value){
      productsCart = value;
      notifyListeners();
    });
  }

  Future search({String productName}) async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    print("The number of products detected is ${productsSearched.length}");

    notifyListeners();

  }



}