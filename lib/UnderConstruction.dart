import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/LandingActivity.dart';
import 'package:healthcareapp/ViewCart.dart';

import 'SearchMedicine.dart';

class UnderConstruction extends StatefulWidget {
  final String title;

  const UnderConstruction({super.key, required this.title});

  @override
  State<UnderConstruction> createState() => UnderConstructionState(title);
}

class UnderConstructionState extends State<UnderConstruction> {

  String title;
  static const List<Widget> _widgetOptions = <Widget>[
    LandingActivity(),
    SearchMedicine(),
    ViewCartWidget()
  ];

  UnderConstructionState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
          title: Text(
            title,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'The page is under construction...',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: const Color(0xFFF83F3F),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            )
          ],
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