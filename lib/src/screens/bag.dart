import 'package:delivery_app/src/models/products.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/widgets/featured_products.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Cart extends StatefulWidget {


  int total;

  PermissionName permissionName = PermissionName.Location;

  Cart();


  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  CameraPosition cameraPosition = CameraPosition(
      target: LatLng(-33,150)
  );

  String launchUrl = "https://www.google.com/maps/search/?api=1&query=44.44355457433514, 26.118855198389834";
  
  Future<void> _launchInBrowser(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    }
    else {
      throw 'Could not launch $url';
    }

  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    
    return Scaffold(
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
                        child: CustomText(text: "2", color: Colors.red, size: 16, weight: FontWeight.bold,),
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
                height: 230,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (_,index){
                      return ProductWidget(product: productProvider.products[index],);
                    },


                  ),
              ),

                GestureDetector(
                    onTap: (){
                     _launchInBrowser(launchUrl);
                    },
                    child: CustomText(text: "Go to location"))
             ],
            ),
         ),



         
      );



  }
}

