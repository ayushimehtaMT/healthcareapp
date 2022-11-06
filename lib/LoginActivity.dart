import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    ProcessLogin login = ProcessLogin();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          child: Image.asset('assets/launch_image.png'),
        ),
        const SizedBox(height: 30,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Username',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SizedBox(
            height: 45,
            width: 140,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                login.processLogin();
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                  const LandingActivity()
                  ),
                );
              },
              child: Text(
                'Login',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProcessLogin {

  processLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', 'user_1');
  }
}
