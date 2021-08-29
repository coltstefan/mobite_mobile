import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/screens/home.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/material.dart';

class StepThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
        title: Padding(
          padding: const EdgeInsets.all(92.0),
          child: CustomText(text: "Step 3", color: Colors.black, size: 22, weight: FontWeight.bold,),
        ),
        elevation: 0.9,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset("images/Mobite-Animation.gif"),
          ),

        ],
      ),

      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Container(
                      height: 240,
                      width: 300,
                      color: Colors.white,
                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset("images/step3.jpeg"),

                      ) ,

                    ),
                  ),
                ),

              ],

            ),
          ),

          Container(
            height: 0.5,
            color: Colors.red,
          ),

          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Center(child: CustomText(text: "    You have to get to the restaurant within 30 minutes,            or your reservation will cancel." +" However, if the offer is still active and not booked, you can buy it on the spot.", size: 15, weight: FontWeight.bold,)),


          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: CustomText(text: "The cashier will give you the PIN \n   in order to complete the order", size: 16, weight: FontWeight.bold,),


          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(text: "Just put in the PIN and you are good to go!", size: 16, weight: FontWeight.bold,),


          ),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: (){
                changeScreen(context, Home());
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: CustomText(text: "Finish!",  color: Colors.white, size: 22, weight: FontWeight.bold,)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
