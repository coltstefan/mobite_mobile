import 'package:delivery_app/src/helpers/style.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/widgets/featured_products.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.close),onPressed: (){
          Navigator.pop(context);
        }),
        title: CustomText(text: "Found Products", color: Colors.black, weight: FontWeight.bold, size: 20,),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){})
        ],
      ),
      body: productProvider.productsSearched.length < 1 ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, color: Colors.grey, size:30)
            ],
          ),
          SizedBox(height: 15,),
          CustomText(text: "No Products Found" , color: grey, weight: FontWeight.w300, size: 22,),
        ],
      ) : ListView.builder(
         // scrollDirection: Axis.horizontal,
          itemCount: productProvider.productsSearched.length,
          itemBuilder: (context,index){
            return ProductWidget(product: productProvider.productsSearched[index]);
          }),
    );
  }
}
