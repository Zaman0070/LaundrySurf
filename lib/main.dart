import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/provider/cart_provider.dart';
import 'package:laundry_app/provider/order_provider.dart';
import 'package:laundry_app/provider/product_provider.dart';
import 'package:laundry_app/provider/user_provider.dart';
import 'package:laundry_app/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context)=>ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context)=>UserProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context)=>CartProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context)=>OrderProvider(),
        ),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation, DeviceType deviceType)=>
            MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ) ),
    );
  }
}

