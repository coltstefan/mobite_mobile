import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/models/restaurant.dart';
import 'package:delivery_app/src/providers/app.dart';
import 'package:delivery_app/src/providers/category.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/providers/restaurant.dart';
import 'package:delivery_app/src/providers/user.dart';
import 'package:delivery_app/src/screens/bag.dart';
import 'package:delivery_app/src/screens/category.dart';
import 'package:delivery_app/src/screens/login.dart';
import 'package:delivery_app/src/screens/product_search.dart';
import 'package:delivery_app/src/screens/restaurant.dart';
import 'package:delivery_app/src/screens/restaurants_search.dart';
import 'package:delivery_app/src/widgets/bottom_navigation_icons.dart';
import 'package:delivery_app/src/widgets/categories.dart';
import 'package:delivery_app/src/widgets/featured_products.dart';
import 'package:delivery_app/src/widgets/loading.dart';
import 'package:delivery_app/src/widgets/loading3.dart';
import 'package:delivery_app/src/widgets/restaurant.dart';
import 'package:delivery_app/src/widgets/small_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission/permission.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/main.dart';

import '../helpers/style.dart';
import '../widgets/title.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    PermissionName permissionName = PermissionName.Location;



    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.9,
        backgroundColor: Colors.red,
        leading: Container(),
        title: CustomText(text: "Mobite", color: Colors.white, size: 24, weight: FontWeight.bold,),

        actions: [
          Stack(
            children:<Widget> [
              IconButton(icon: Icon(Icons.person_add_disabled), onPressed: () async{
                user.signOut();
                changeScreen(context, LoginScreen());
              },),


            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children:<Widget> [
                //IconButton(icon: Icon(Icons.notifications_none), onPressed: (){}),
                Image.asset("images/final.jpg", height: 40, width: 40,),


              ],
            ),
          )
        ],
      ),
      /*drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red
              ),
                accountName: CustomText(text: "coltstefan", weight: FontWeight.bold, color: Colors.white,),
                accountEmail: CustomText(text: "coltstefan@gmail.com", color: Colors.white,)),

            ListTile(
              onTap: (){},
              leading: Icon(Icons.home),
              title: CustomText(text: "Home",),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My Orders",),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart",),
            ),
            ListTile(
              onTap: (){
                user.signOut();
                changeScreen(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log Out",),
            )

          ],
        ),
      ),*/
      backgroundColor: white ,
      body: app.isLoading ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Loading()
          ],
        ),
      ) :SafeArea(
        child:ListView(
        children: <Widget> [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30) , bottomRight: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 15),
              child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(30),

                  ),
                  child: ListTile(
                    leading: Icon(Icons.search, color: Colors.red),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                        onSubmitted: (pattern) async{

                        if(app.search == SearchBy.PRODUCTS) {
                          await productProvider.search(productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        }else {
                          await restaurantProvider.search(name: pattern);
                          changeScreen(context, RestaurantsSearchScreen());

                        }

                        },
                        decoration: InputDecoration(
                            hintText: "Find food and restaurants",
                            border: InputBorder.none
                        )
                    ),



                  )

              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(text: "Search by: ", color: Colors.grey, weight: FontWeight.w700, size: 16,),
                DropdownButton<String>(
                  value: app.filterBy,

                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                  ),
                  icon: Icon(Icons.filter_list,
                      color: Colors.red),
                  elevation: 0,
                  onChanged: (value){
                    if (value == "Products"){
                      app.changeSearchBy(newsearchBy: SearchBy.PRODUCTS);
                    }
                    else {
                      app.changeSearchBy(newsearchBy: SearchBy.RESTAURANTS);
                    }
                  },
                  items: <String>["Products", "Restaurants"].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value));
                  }).toList(),

                ),
              ],
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height: 100,
              child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context,index){
                return GestureDetector(
                    onTap: () async{
                      await  productProvider.loadProductsByCategory(categoryName: categoryProvider.categories[index].name);
                       changeScreen(context, CategoryScreen(categoryModel:categoryProvider.categories[index],));
                },
                    child: CategoryWidget(category: categoryProvider.categories[index],));
              }),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16,8,8,1),
            child: CustomText(text: "Available Offers", size: 20, color: grey,),
          ),

        Container(
           height: 230,
           child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productProvider.products.length,
            itemBuilder: (_,index) {
              return ProductWidget(product: productProvider.products[index],);
            }
            ),),


          Padding(
            padding: const EdgeInsets.fromLTRB(16,8,8,1),
            child: CustomText(text: "Open Restaurants",color: grey,size:20),
          ),



          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,10),
            child: Column(
              children: restaurantProvider.restaurants.map((item) => GestureDetector(
                  onTap : () async{
                    app.changeLoading();
                    await  productProvider.loadProductsByRestaurant(restaurantId : item.id);
                    app.changeLoading();
                    changeScreen(context, RestaurantScreen(restaurantModel :item ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RestaurantWidget(restaurant: item,),
                  ))).toList()
            ),
          )
    ],
    ),
    ),


    );
  }
}
