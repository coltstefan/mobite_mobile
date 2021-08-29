import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/src/helpers/user.dart';
import 'package:delivery_app/src/models/cart_item.dart';
import 'package:delivery_app/src/models/products.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Status{Uninitialized , Unauthenticated , Authenticating , Authenticated}

class UserProvider with ChangeNotifier{

  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  UserModel _userModel;

  // getters

  Status get status => _status;
  UserModel get userModel => _userModel;

  User get user => _user;

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChanged);
  }
  
  Future<bool> signIn() async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      return true;
    } catch(e){
      return _onError(e.toString());
    }
  }

  Future signOut(){
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }



  
  Future<bool> signUp() async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result) {
        _firestore.collection('users').doc(result.user.uid).set({
          "name": name.text,
          "email": email.text,
          "id": result.user.uid,
          "likedFood" : [],
          "likedRestaurants" : []
        });
      });
      return true;
    }catch(e){
      return _onError(e.toString());
    }
  }


  Future<bool> addToCard({ProductModel product, int quantity})async{
    print("THE PRODUC IS: ${product.toString()}");
    print("THE qty IS: ${quantity.toString()}");

   // try{
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = [];
      bool itemExists = false;
      Map cartItem ={
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "restaurantId": product.restaurantId,
        "totalRestaurantSale": product.price * quantity,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

     for(Map item in cart){
       if(item["productId"] == cartItem["productId"]){
         item["quantity"] = item["quantity"] + quantity;
         itemExists = true;
       }
     }
      if(!itemExists) {
        cart.add(cartItem);
      }
//      }
      print("CART ITEMS ARE: ${cart.toString()}");

      _userServices.editCart(userId: _userModel.id , cart: cart);


     // return true;
   /* }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }*/

  }


  Future<void> _onStateChanged(User firebaseUser) async{
    if (user == null) {
    _status = Status.Uninitialized;
      } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(firebaseUser.uid);
    }

    notifyListeners();

  }

//general methods
  bool _onError(String error){
    _status = Status.Unauthenticated;
    notifyListeners();
    print("Error"+ error);
    return false;
  }

  void clearControllers(){
    email.text = "";
    password.text = "";
    name.text = "";


  }


}