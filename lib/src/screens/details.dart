import 'file:///C:/Users/colts/AndroidStudioProjects/delivery_app/lib/src/helpers/style.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/helpers/style.dart';
import 'package:delivery_app/src/models/products.dart';
import 'package:delivery_app/src/providers/app.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/providers/restaurant.dart';
import 'package:delivery_app/src/providers/user.dart';
import 'package:delivery_app/src/screens/home.dart';
import 'package:delivery_app/src/screens/restaurant.dart';
import 'package:delivery_app/src/widgets/loading.dart';
import 'package:delivery_app/src/widgets/small_button.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/src/models/cart_item.dart';

class Details extends StatefulWidget {

  ProductModel product;



  Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;


  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

     final user = Provider.of<UserProvider>(context);
     final app = Provider.of<AppProvider>(context);
     final productProvider = Provider.of<ProductProvider>(context);
     final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: Colors.red[200],
     /* appBar: AppBar(
        shadowColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.black),
        // leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,),onPressed: null,),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: widget.product.name, size: 20, weight: FontWeight.w700,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset("images/final.jpg" , width: 30, height: 30,),
                ),


              ],
            ),
          ),

        ],
      ),*/
      body:

      SafeArea(

        child:  Column(

          children: [
            SizedBox(height: 30,),
            CircleAvatar(
              radius: 200,
              backgroundColor: Colors.red[200],
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange[100],
                      offset: Offset(3,3),
                      blurRadius: 100
                    )
                  ]
                ),
                child: CircleAvatar(
                  radius: 156,

                  child: CircleAvatar(
                    radius: 154,
                    backgroundImage: AssetImage('${widget.product.image}'),
                  ),
                ),
              ),
            ),

            Center(child: CustomText(text: widget.product.name, size: 24, color: Colors.red[700], weight: FontWeight.bold,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "\$${widget.product.price}", size: 22, color: Colors.red[700], weight: FontWeight.w500,),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: () async{
                await  productProvider.loadProductsByRestaurant(restaurantId : widget.product.restaurantId);

                await restaurantProvider.loadSingleRestaurant(restaurantId: widget.product.restaurantId);
                changeScreen(context, RestaurantScreen(restaurantModel: restaurantProvider.restaurant,));
              },
              child: Container(

                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red[300],
                      offset: Offset(3,3),
                      blurRadius: 3
                    )
                  ]


                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CustomText(text: "Go to " + widget.product.restaurant, color: Colors.white, size: 22, weight: FontWeight.bold,),
                ),

              ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: (){
                    changeScreen(context, Home());
                  },
                  child: IconButton(icon: Icon(Icons.arrow_back_outlined), onPressed: null)),
            ),

          ],




        ),

      ),
    );
  }
}
