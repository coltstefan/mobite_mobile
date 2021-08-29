import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/models/products.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/providers/restaurant.dart';
import 'package:delivery_app/src/screens/details.dart';
import 'package:delivery_app/src/screens/restaurant.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/style.dart';

List<String> images = [
  "1.jpg",
  "2.jpg",
  "3.jpg",
  "4.jpg",
  "5.jpg",
];

class ProductRestaurant extends StatelessWidget {
  final ProductModel product;


  const ProductRestaurant({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> cartList = [];
    return  Padding(padding: EdgeInsets.fromLTRB(12,14,16,12),
      child:GestureDetector(
        onTap: (){
          changeScreen(context, Details(product: product,));
        },
        child: Container(
          height: 240,
          width: 280,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: white,
              boxShadow: [
                BoxShadow(
                    color: grey[500],
                    offset: Offset(6, 6),
                    blurRadius: 15


                )
              ]
          ),
          child: Column(
            children: <Widget>[
              Image.asset("${product.image}", height:140, width: 140,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12,8,0,8),
                    child: CustomText(text: product.name, weight: FontWeight.bold,),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,5,80,8),
                    child: GestureDetector(
                        onTap: () async{
                          await  productProvider.loadProductsByRestaurant(restaurantId : product.restaurantId);

                          await restaurantProvider.loadSingleRestaurant(restaurantId: product.restaurantId);
                          changeScreen(context, RestaurantScreen(restaurantModel: restaurantProvider.restaurant,));
                        },
                        child: CustomText(text: "by " + product.restaurant, size: 14, color: Colors.red[300],)),
                  ),
                  Padding(padding: EdgeInsets.all(8),
                    child: Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                                color: grey[300],
                                offset: Offset(1, 1),
                                blurRadius: 4


                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                            onTap: (){
                            cartList.add(product);
                            print(product.name + " Was added");
                            print(cartList[0].name);

                            },
                            child: Icon(Icons.add,color: cartList.contains(product) ? Colors.green: Colors.red ,size:18,)) ,
                      ),
                    ),)
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(

                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(left:12.0),
                        child: CustomText(text: "${product.rating}", color:grey,size: 14,),
                      ),
                      SizedBox(width: 2,),
                      Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: grey,
                        size: 16,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:12.0),
                    child: CustomText(text: "\$${product.price}", weight: FontWeight.bold,),
                  )
                ],
              )

            ],
          ) ,
        ),
      ),);


  }
}
