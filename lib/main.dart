import 'package:delivery_app/src/providers/app.dart';
import 'package:delivery_app/src/providers/category.dart';
import 'package:delivery_app/src/providers/product.dart';
import 'package:delivery_app/src/providers/restaurant.dart';
import 'package:delivery_app/src/providers/user.dart';
import 'package:delivery_app/src/screens/home.dart';
import 'package:delivery_app/src/screens/login.dart';
import 'package:delivery_app/src/screens/step1.dart';
import 'package:delivery_app/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
    ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),

  ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MoBite',
    theme: ThemeData(

      primarySwatch: Colors.red,

      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: ScreensController(),
  ),));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch(auth.status) {
      case Status.Uninitialized:
        return LoginScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default: return LoginScreen();
    }
    return Container();
  }
}





/*class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoBite',
      theme: ThemeData(

        primarySwatch: Colors.red,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}*/

