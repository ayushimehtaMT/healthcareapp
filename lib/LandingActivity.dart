import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/UnderConstruction.dart';
import 'package:healthcareapp/ViewCart.dart';

import 'SearchMedicine.dart';

class LandingActivity extends StatefulWidget {
  const LandingActivity({super.key});

  @override
  State<LandingActivity> createState() => LandingActivityState();
}

class LandingActivityState extends State<LandingActivity> {
  static const List<Widget> _widgetOptions = <Widget>[
    LandingActivity(),
    SearchMedicine(),
    ViewCartWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          'Home',
          style: GoogleFonts.getFont(
            'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 64,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Menu',
                      style: TextStyle(fontSize: 18, color: Colors.white)
                  ),
                )
            ),
            ListTile(
              leading: const Icon(
                Icons.explore,
              ),
              title: const Text('Order Medicine',
                  style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins')
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => const SearchMedicine()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.commute,
              ),
              title: const Text('Book Lab Appointment',
                  style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins')
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => const UnderConstruction(title: 'Book Lab Appointment')),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.medical_services,
              ),
              title: const Text('Book Doctor Appointment',
                  style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins')
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => const UnderConstruction(title: 'Book Doctor Appointment')),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  _widgetOptions.elementAt(index),
              ),
            );
          });
        },
        currentIndex: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        selectedItemColor: const Color(0xFFF83F3F),
      )
    );
  }
}