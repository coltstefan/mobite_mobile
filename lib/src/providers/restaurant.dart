import 'dart:async';

import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../helpers/restaurant.dart';

class RestaurantProvider with ChangeNotifier{

  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  RestaurantModel restaurant;

  RestaurantProvider.initialize(){

      _loadRestaurant();
    //  print(restaurants[1].url);
      search();
    }



  _loadRestaurant() async {

    await _restaurantServices.getRestaurants().then((value){
      restaurants = value;
      print(restaurants[1].name);
      notifyListeners();
      });


  }

  loadSingleRestaurant({int restaurantId}) async {

    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future search({String name}) async{
   searchedRestaurants = await _restaurantServices.searchRestaurant(restaurantName: name);
   print("RESTOS ARE : ${searchedRestaurants.length}");
   notifyListeners();
  }

}