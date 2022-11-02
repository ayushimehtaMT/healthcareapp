import 'package:flutter/material.dart';

import 'LandingActivity.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({super.key, required this.title});
  final String title;

  @override
  State<LoginActivity> createState() => LoginActivityState();
}

class LoginActivityState extends State<LoginActivity> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Username',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  MaterialApp(
                title: "Health Care Landing Page",
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                //home: const LandingActivity(title: 'Health Care Landing Page'),
                home: Scaffold(
                  appBar: AppBar(
                    title: Text('Health Care Landing'),
                  ),
                  body: const LandingActivity(title: 'Health Care Landing Page'),
                ),
              )),//const LandingActivity(title: 'Health Care Landing Page')),
              );
            },//home: const LandingActivity(title: 'Health Care Landing Page');},
          child: Text('Login'),
        ),
    ),
      ],
    );
  }
}