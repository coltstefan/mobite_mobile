import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/models/restaurant.dart';
import 'package:delivery_app/src/screens/complete.dart';
import 'package:delivery_app/src/screens/home.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:pin_code_fields/pin_code_fields.dart';

class Reciept extends StatefulWidget {
   RestaurantModel restaurantCurent;
   int price;
   String name;

   Reciept({this.restaurantCurent , this.price , this.name});


  @override
  _RecieptState createState() => _RecieptState();
}

class _RecieptState extends State<Reciept> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    String launchUrlpza = "https://www.google.com/maps/search/?api=1&query=44.44355457433514, 26.118855198389834";
    String launchUrldom = "https://www.google.com/maps/search/?api=1&query=44.4337282481553, 26.01286965901267";
    String launchUrldodo = "https://www.google.com/maps/search/?api=1&query=44.38505789783355, 26.11610146727886";
    var rng = new Random();
    int pass = rng.nextInt(9999);
    print (pass);
    print (pass);
    print (pass);
    print (pass);
    print (pass);

    DateTime now = DateTime.now().add(new Duration(minutes: 30));
    //now.add(new Duration(minutes: 30));



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
      backgroundColor: Colors.white,
     appBar: AppBar(
       iconTheme: IconThemeData(color: Colors.black),
       // leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,),onPressed: null,),
       backgroundColor: Colors.white,
       elevation: 0,
       centerTitle: true,
       title: CustomText(text: "Reciept", size: 20, weight: FontWeight.w700,),
       actions: [
         Padding(
           padding: const EdgeInsets.only(top: 2.0),
           child: Stack(
             children: [
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Image.asset("images/shopping-bag.png" , width: 30, height: 30,),
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
                       child: CustomText(text: "\$${widget.price}", color: Colors.red, size: 16, weight: FontWeight.bold,),
                     )),
               ),

             ],
           ),
         ),

       ],
     ),
      
      body: //SafeArea(
        //child:
        ListView(
          scrollDirection: Axis.vertical,
          children: [ Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: "Hello, ${widget.name}", size: 24,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: "Thank you for booking a meal and choosing to help your local business save some money!" , color: Colors.grey[700], size: 18,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: "You can pay and pick up your food at the restaurant when you get there, but hurry up, you have 30 minutes from now: ", color: Colors.grey[700], size: 19,),
              ),
              CustomText(text: now.hour.toString() + ":" + "${now.minute.toString()}", size: 22, weight: FontWeight.bold,),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: "Don't know how to get there? No problem" , color: Colors.grey[700], size: 19,),
              ),
              CustomText(text: "Tap the eating racoon" , color: Colors.grey[700], size: 19,),
              GestureDetector(
                onTap: (){
                  if(widget.restaurantCurent.name == "Pizza Hut")
                    _launchInBrowser(launchUrlpza);
                  if(widget.restaurantCurent.name == "Dominos")
                    _launchInBrowser(launchUrldom);
                  if(widget.restaurantCurent.name == "Dodo")
                    _launchInBrowser(launchUrldodo);
                },
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset("images/Mobite-Animation.gif", height: 120,width: 120,),
                ),


              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: "If you got your food, please put in the PIN that your cashier gave you", size: 19, color: Colors.grey[700], weight: FontWeight.bold,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: TextField(
                  textAlign: TextAlign.center,
                  onSubmitted: (pattern){
                   if(pass.toString() == pattern){
                     changeScreenReplacement(context, Complete(restaurant: widget.restaurantCurent, name: widget.name,));

                   }
                   else{
                     _key.currentState.showSnackBar(
                       SnackBar(content: Text("Wrong Passcode"),)
                     );
                   }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Passcode",
                      border: InputBorder.none

                  ),

                ),
              )


            ],
          ),
    ],
        ),

    );
  }
}
