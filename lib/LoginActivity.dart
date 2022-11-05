import 'package:flutter/material.dart';

import 'LandingActivity.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({super.key, required this.title});
  final String title;

  @override
  State<LoginActivity> createState() => LoginActivityState();
}

class LoginActivityState extends State<LoginActivity> {

  TextEditingController passController = new TextEditingController();
  TextEditingController usrController = new TextEditingController();

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
            controller: passController,
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

class Validator {
  static String? validateName({required String name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }
  static String? validatePassword({required String password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 3) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }
}