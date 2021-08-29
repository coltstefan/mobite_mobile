import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/helpers/style.dart';
import 'package:delivery_app/src/models/restaurant.dart';
import 'package:delivery_app/src/screens/home.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/material.dart';


class Complete extends StatelessWidget {

  RestaurantModel restaurant;
  String name;

  Complete({this.restaurant , this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        leading: Container(),
        title: Padding(
          padding: const EdgeInsets.all(34.0),
          child: CustomText(text: "Order Complete", size: 22, weight: FontWeight.bold,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset("images/Mobite-Animation.gif"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.verified, color: Colors.red, size: 200,),
            ),
            
            CustomText(text: "Cheers, ${name}", size: 20, color: Colors.red, weight: FontWeight.bold,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Enjoy your meal, we hope you will\n order from us again in the future", size: 20, color: Colors.red, weight: FontWeight.bold,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Maybe from ${restaurant.name} again" , size: 20, color: Colors.red, weight: FontWeight.bold,),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: " Or from any other restaurant \n                 in our offer", size: 20, color: Colors.red, weight: FontWeight.bold,),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Have a nice day", size: 20, color: Colors.red, weight: FontWeight.bold,),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  changeScreenReplacement(context, Home());
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red[200],
                        offset: Offset(2,2),
                        blurRadius: 3
                      )
                    ]
                  ),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(29,12,8,8),
                    child: CustomText(text: "Get back Home!", size: 20, color: Colors.white, weight: FontWeight.bold,),
                  ),
                ),
              ),
            )


          ],

        ),
      ),
    );
  }
}
