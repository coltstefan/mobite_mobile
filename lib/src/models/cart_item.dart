import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/src/models/products.dart';

class CartItemModel {
 List<ProductModel> products;
 int total=0;

 void addToCart(ProductModel product){
   products.add(product);
 }

 void addToTotal(int price){
   this.total = this.total + price;
 }

}