import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel{
  static const NAME = "name";
  static const ID = "id";
  //static const AVG_PRICE = "avgPrice";
  static const RATING = "rating";
  //static const RATES = "rates";
  static const IMAGE = "image";
  //static const URL = "url";//static const POPULAR = "popular";

  int _id;
  String _name;
 // double _avgPrice;
  double _rating;
  String _image;
  String _url;
 // bool _popular;
//  int _rates;

  //GETTERS

  int get id => _id;
  String get name => _name;
 // double get avgPrice => _avgPrice;
  double get rating => _rating;
  String get image => _image;
  //String get url => _url;
//  bool get popular => _popular;
//  int get rates => _rates;

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
  //  _avgPrice = snapshot.data()[AVG_PRICE];
    _rating = snapshot.data()[RATING];
    _image = snapshot.data()[IMAGE];
   //_url = snapshot.data()[URL];
   // _popular = snapshot.data()[POPULAR];
  //  _rates = snapshot.data()[RATES];
//
  }



}