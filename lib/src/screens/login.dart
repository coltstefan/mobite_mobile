import 'package:delivery_app/src/helpers/screen_navigation.dart';
import 'package:delivery_app/src/providers/user.dart';
import 'package:delivery_app/src/screens/home.dart';
import 'package:delivery_app/src/screens/registration.dart';
import 'package:delivery_app/src/widgets/loading.dart';
import 'package:delivery_app/src/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: authProvider.status == Status.Authenticating ? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:40.0),
                  child: Image.asset("images/final.jpg", height: 240, width: 240,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    controller: authProvider.email,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      icon: Icon(Icons.email, color: Colors.red,)
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: authProvider.password,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock, color: Colors.red,)
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()async{
                  if(!await authProvider.signIn()){
                    _key.currentState.showSnackBar(
                    SnackBar(content: Text("Login failed!"))
                    );
                    return;
                  }
                  authProvider.clearControllers();
                  changeScreenReplacement(context, Home());
                  },
                  child: Container(
                  //color: Colors.red,
                  decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                  padding: const EdgeInsets.only(top:10.0, bottom: 10),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  CustomText(text: "Login", size: 18, weight: FontWeight.bold, color: Colors.white,
                )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  changeScreen(context, RegistrationScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "Don't have an account yet? Register here!" , size: 18,),
                  ],
                ),
              ),
            ),
          ],
        )
      ),


    );
  }
}

