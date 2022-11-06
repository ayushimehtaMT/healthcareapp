import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/CartProvider.dart';
import 'package:healthcareapp/LoginActivity.dart';
import 'package:healthcareapp/PreviousOrdersProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<CartProvider>(create: (context) => CartProvider()),
      ChangeNotifierProvider<PreviousOrdersProvider>(create: (context) => PreviousOrdersProvider())
    ],
    child: const MyApp(),
  ));
      // ChangeNotifierProvider(
      //   create: (context) => CartProvider(),
      //   child: const MyApp(),
      // ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: LoginActivity(title: 'Login'),
      ),
    );


    // return ChangeNotifierProvider(create: (_) => CartProvider(),
    //   child: Builder(builder: (BuildContext context) {
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'MedApp',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       home: const ViewCartWidget(),
    //     );
    //   }),
    // );
  }
}