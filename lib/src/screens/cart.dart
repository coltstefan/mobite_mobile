import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/helpers/style.dart';
import 'package:delivery_app/src/models/products.dart';
import 'package:delivery_app/src/models/restaurant.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/screens/reciept.dart';
import 'package:delivery_app/src/widgets/featured_products.dart';
import 'package:delivery_app/src/widgets/product_restaurant.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'details.dart';


class CartNou extends StatefulWidget {
   RestaurantModel restaurantCurent;

  CartNou({this.restaurantCurent});

  @override
  _CartNouState createState() => _CartNouState();
}

class _CartNouState extends State<CartNou> {
  int quantity = 0;
  int quantity1 = 0;
  int quantity2 =0;

  Color culoare = Colors.red;
  IconData adauga = Icons.add_circle_outline;
  int total = 0;

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);
    String launchUrlpza = "https://www.google.com/maps/search/?api=1&query=44.44355457433514, 26.118855198389834";
    String launchUrldom = "https://www.google.com/maps/search/?api=1&query=44.4337282481553, 26.01286965901267";
    String launchUrldodo = "https://www.google.com/maps/search/?api=1&query=44.38505789783355, 26.11610146727886";
    List<ProductModel> cartProducts = List<ProductModel>();
    String dropdownValue = "Right Now";
    String numele;



    Future<void> _launchInBrowser(String url) async {
      if(await canLaunch(url)){
        await launch(url);
      }
      else {
        throw 'Could not launch $url';
      }

    }
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        // leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,),onPressed: null,),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Cart", size: 20, weight: FontWeight.w700,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12,12,20,12),
                  child: Icon(Icons.shopping_cart_outlined, color: Colors.black,),
                  //Image.asset("images/shopping-bag.png" , width: 30, height: 30,),
                ),
                Positioned(
                  bottom: 9,
                  right: 12,

                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400],
                                offset: Offset(2,1),
                                blurRadius: 3

                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                        child: CustomText(text: "${quantity}", color: Colors.red, size: 16, weight: FontWeight.bold,),
                      )),
                ),

              ],
            ),
          ),

        ],
      ),
      backgroundColor: Colors.white,
      body:
      SafeArea(
        child: Column(
          children:  [
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:productProvider.productsByRestaurant.length,
                itemBuilder: (_,index){
                  return Padding(padding: EdgeInsets.fromLTRB(12,14,16,12),
                    child:GestureDetector(
                      onTap: (){
                        //changeScreen(context, Details(product: productProvider.productsByRestaurant[index],));
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
                                  offset: Offset(6, 2),
                                  blurRadius: 15


                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Image.asset("${productProvider.productsByRestaurant[index].image}", height:140, width: 140,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(12,8,0,8),
                                  child: CustomText(text: productProvider.productsByRestaurant[index].name, weight: FontWeight.bold,),
                                ),

                                Padding(padding: EdgeInsets.fromLTRB(20,4,4,4),
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
                                          setState(() {
                                            if(quantity>0 && quantity1>0 && index == 0)
                                              { quantity1--;
                                               quantity--;
                                               total = total - productProvider.productsByRestaurant[index].price.toInt();
                                              }
                                            if(quantity>0 && quantity2>0 && index == 1)
                                            { quantity2--;
                                            quantity--;
                                            total = total - productProvider.productsByRestaurant[index].price.toInt();
                                            }


                                           // culoare = Colors.green;


                                          });

                                        },
                                        child: Icon(Icons.remove_circle_outline,color: culoare) ,
                                      ),
                                    ),
                                  ),),

                                CustomText(text: index==0 ? quantity1.toString() : quantity2.toString()),

                                Padding(padding: EdgeInsets.fromLTRB(8,8,8,8),
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
                                           setState(() {
                                             if(index == 0)
                                            { quantity1++;
                                              quantity++;
                                             //culoare = Colors.green;
                                             total = total + productProvider.productsByRestaurant[index].price.toInt();}
                                             if(index == 1)
                                             { quantity2++;
                                               quantity++;
                                             //culoare = Colors.green;
                                             total = total + productProvider.productsByRestaurant[index].price.toInt();}

                                           });

                                          },
                                          child: Icon(Icons.add_circle_outline,color: culoare) ,
                                    ),
                                  ),
                                  ),),

                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(

                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.only(left:12.0),
                                      child: CustomText(text: "${productProvider.productsByRestaurant[index].rating}", color:grey,size: 14,),
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
                                  child: CustomText(text: "\$${productProvider.productsByRestaurant[index].price}", weight: FontWeight.bold,),
                                )
                              ],
                            )

                          ],
                        ) ,
                      ),
                    ),);
                },


              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 50,
                      width: 120,
                      decoration: BoxDecoration(

                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 15, 10, 10),
                        child: CustomText(text: "Total: \$${total}" , color: Colors.white, weight: FontWeight.bold,),
                      )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,8,0,8),
                      child: Container(
                        width: 230,
                        child: ListTile(
                         // leading: Icon(Icons.person),
                          title: TextField(
                            textAlign: TextAlign.center,
                            onSubmitted: (pattern){
                              numele = pattern;
                              print(numele);
                            },
                            decoration: InputDecoration(
                              hintText: "What's your full name?",
                              border: InputBorder.none

                            ),

                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        changeScreenReplacement(context, Reciept(restaurantCurent: widget.restaurantCurent, price: total, name: numele,));
                        print(widget.restaurantCurent.name);
                        print(numele);
                      },
                      child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(

                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(22, 15, 10, 10),
                            child: CustomText(text: "Book Offer" , color: Colors.white, weight: FontWeight.bold,),
                          )),
                    ),
                  ],
                ),

                /*  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                        icon: Icon(Icons.timer, color: red,),
                        iconSize: 14,
                        elevation: 16,
                        onChanged: (String newValue){
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[ '17:00' , '17:15', '17:30' , '17:45' , '18:00' , '18:15' , '18:30' , '18:45' , '19:00' , '19:15' , '19:30'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value));
                        }).toList(),
                        ),
                  )*/

                ],
              ),
            ),


          ],
        ),
      ),




    );
  }
}
