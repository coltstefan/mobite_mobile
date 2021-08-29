import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.red[200],
              offset: Offset(3,3),
              blurRadius: 100
            )
          ]
        ),
        child: CircleAvatar(
          backgroundColor: Colors.red[300],
          radius: 250,
          child: Padding(
            padding: const EdgeInsets.only(right: 0,left: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(text: "Saving the world", size: 22, color: Colors.white, weight: FontWeight.bold,),
                  ),
                  Image.asset("images/Mobite-Animation.gif", height: 250, width: 250,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(text: "one bite at a time...", size: 22, color: Colors.white, weight: FontWeight.bold,),
                  )

                  //CircularProgressIndicator()
                ],

              ),

          ),
        ),
      ),
    );
  }
}
