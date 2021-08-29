import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
           backgroundColor: Colors.red,
           body: Column(

             children: [
               CustomText(text: "Saving the world",),


             ],

           ),

    );
  }
}
