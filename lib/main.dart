import 'package:flutter/material.dart';
import 'package:healthcareapp/CartProvider.dart';
import 'package:healthcareapp/LandingActivity.dart';
import 'package:healthcareapp/LoginActivity.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: const MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title='Health Care App';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: Scaffold(
        appBar: AppBar(
        title: Text('Login'),
      ),
        body: const LoginActivity(title: 'Login'),
      ),
    );
  }
}