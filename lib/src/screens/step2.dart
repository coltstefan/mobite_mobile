import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/screens/step3.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/material.dart';

class StepTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
        title: Padding(
          padding: const EdgeInsets.all(92.0),
          child: CustomText(text: "Step 2", color: Colors.black, size: 22, weight: FontWeight.bold,),
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
            child: Center(
              child: Container(
                height: 220,
                width: 240,
                color: Colors.white,
                child: FittedBox(child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset("images/step2.jpeg"),

                ) , fit: BoxFit.fill,),

              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left:40.0),
            child: CustomText(text: "Once you find a restaurant, choose what you would like to eat from the available offers.", size: 16, weight: FontWeight.bold,),


          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(text: "Put in your name, so the cashier can identify you.", size: 16, weight: FontWeight.bold,),


          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(text: "Then tap Book Offer", size: 16, weight: FontWeight.bold,),


          ),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: (){
                changeScreen(context, StepThree());
              },
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: CustomText(text: "Next",  color: Colors.white, size: 22, weight: FontWeight.bold,)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
