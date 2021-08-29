import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/helpers/style.dart';
import 'package:delivery_app/src/models/restaurant.dart';
import 'package:delivery_app/src/providers/app.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/providers/restaurant.dart';
import 'package:delivery_app/src/screens/restaurant.dart';
import 'package:delivery_app/src/widgets/featured_products.dart';
import 'package:delivery_app/src/widgets/loading.dart';
import 'package:delivery_app/src/widgets/restaurant.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.close),onPressed: (){
          Navigator.pop(context);
        }),
        title: CustomText(text: "Found Restaurants", color: Colors.black, weight: FontWeight.bold, size: 20,),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){})
        ],
      ),
      body: app.isLoading ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Loading()
          ],
        ),
      ) : restaurantProvider.searchedRestaurants.length < 1 ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, color: Colors.grey, size:30)
            ],
          ),
          SizedBox(height: 15,),
          CustomText(text: "No Restaurants Found" , color: grey, weight: FontWeight.w300, size: 22,),
        ],
      ) : ListView.builder(
        // scrollDirection: Axis.horizontal,
          itemCount: restaurantProvider.searchedRestaurants.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.fromLTRB(20,20,20,8),
              child: GestureDetector(
                  onTap: () async{

                    await productProvider.loadProductsByRestaurant(restaurantId: restaurantProvider.searchedRestaurants[index].id);
                    changeScreen(context, RestaurantScreen(restaurantModel: restaurantProvider.searchedRestaurants[index],));
                  },
                  child: RestaurantWidget(restaurant: restaurantProvider.searchedRestaurants[index],)),
            );
          }),
    );
  }
}
