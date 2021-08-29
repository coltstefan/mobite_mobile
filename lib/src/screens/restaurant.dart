import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/helpers/style.dart';
import 'package:delivery_app/src/models/products.dart';
import 'package:delivery_app/src/models/restaurant.dart';
import 'package:delivery_app/src/providers/app.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/screens/bag.dart';
import 'package:delivery_app/src/screens/cart.dart';
import 'package:delivery_app/src/widgets/featured_products.dart';
import 'package:delivery_app/src/widgets/loading.dart';
import 'package:delivery_app/src/widgets/product_restaurant.dart';
import 'package:delivery_app/src/widgets/small_button.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'details.dart';

class RestaurantScreen extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const RestaurantScreen({Key key, this.restaurantModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    String launchUrlpza = "https://www.google.com/maps/search/?api=1&query=44.44355457433514, 26.118855198389834";
    String launchUrldom = "https://www.google.com/maps/search/?api=1&query=44.4337282481553, 26.01286965901267";
    String launchUrldodo = "https://www.google.com/maps/search/?api=1&query=44.38505789783355, 26.11610146727886";



    Future<void> _launchInBrowser(String url) async {
      if(await canLaunch(url)){
        await launch(url);
      }
      else {
        throw 'Could not launch $url';
      }

    }

    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: <Widget>[

              Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      )),

                  // restaurant image
                  ClipRRect(

                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(4),
                    ),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: restaurantModel.image,
                      height: 210,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),

                  // fading black
                  Container(
                    height: 210,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(4),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        )),
                  ),

                  //restaurant name
                  Positioned.fill(
                      bottom: 60,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomText(text: restaurantModel.name, color: white, size: 26, weight: FontWeight.w300,))),

                  // average price


                  // rating widget
                  Positioned.fill(
                      bottom: 2,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child:                 Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow[900],
                                    size: 20,
                                  ),
                                ),
                                Text(restaurantModel.rating.toString()),
                              ],
                            ),
                          ),
                        ),
                      )),

                  // close button
                  Positioned.fill(
                      top: 5,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: black.withOpacity(0.2)
                                ),
                                child: Icon(Icons.close, color: white,)),
                          ),
                        ),)),

                  //like button
                  Positioned.fill(
                      top: 5,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: GestureDetector(
                            onTap: (){
                              if(restaurantModel.name == "Pizza Hut")
                                _launchInBrowser(launchUrlpza);
                              if(restaurantModel.name == "Dominos")
                                _launchInBrowser(launchUrldom);
                              if(restaurantModel.name == "Dodo")
                                _launchInBrowser(launchUrldodo);
                            },
                            child: SmallButton(Icons.location_on),
                          ),
                        ),)),


                ],
              ),
              SizedBox(
                height: 10,
              ),


//              open & book section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomText(text: "Open", color: Colors.green, weight: FontWeight.w400, size: 18,),
                  Container(
                        child: FlatButton.icon(onPressed: () async{

                            await  productProvider.loadProductsByRestaurant(restaurantId : restaurantModel.id);

                            changeScreen(context, CartNou(restaurantCurent : restaurantModel ));
                          },
                            icon: Icon(Icons.restaurant_menu), label: CustomText(text: "Book Now"))),

                ],
              ),

              // products
              Column(
                children: productProvider.productsByRestaurant
                    .map((item) => GestureDetector(
                  onTap: () {
                    changeScreen(context, Details(product: item,));
                  },
                  child: ProductRestaurant(
                    product: item,
                  ),
                ))
                    .toList(),

              ),




            ],

          )),
    );
  }
}