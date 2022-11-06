import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/ActiveOrdersProvider.dart';
import 'package:healthcareapp/PreviousOrderModel.dart';
import 'package:healthcareapp/UnderConstruction.dart';
import 'package:healthcareapp/ViewCart.dart';
import 'package:provider/provider.dart';

import 'SearchMedicine.dart';

class LandingActivity extends StatefulWidget {
  const LandingActivity({super.key});

  @override
  State<LandingActivity> createState() => LandingActivityState();
}

class LandingActivityState extends State<LandingActivity> {
  bool isLoading = true;

  static const List<Widget> _widgetOptions = <Widget>[
    LandingActivity(),
    SearchMedicine(),
    ViewCartWidget()
  ];

  void startTimer() {
    Timer.periodic(const Duration(seconds: 2), (t) {
      setState(() {
        isLoading = false; //set loading to false
      });
      t.cancel(); //stops the timer
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activeOrdersProvider = Provider.of<ActiveOrdersProvider>(context);

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
      body: Column(
        children: [
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 20,),
              Text(
                  'Active Orders',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  )
              )
            ],
          ),
          FutureBuilder(future: activeOrdersProvider.getActiveOrders(),
              builder: (context, AsyncSnapshot<List<PreviousOrder>> snapshot) {
              if (!isLoading) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length <= 3 ? snapshot.data!.length : 3,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18.0, top: 8.0, right: 8.0, bottom: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Order ID',
                                              style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15
                                              ),
                                            ),
                                            Text('Placed At',
                                              style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15
                                              ),
                                            ),
                                            Text('Amount Paid',
                                              style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15
                                              ),
                                            ),
                                            Text('Status',
                                              style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text('OD${snapshot.data![index]!.id!}',
                                                style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15
                                                ),
                                              ),
                                              Text(snapshot.data![index]!.placedAt!,
                                                style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  const Text('₹',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 17,
                                                    ),),
                                                  Text(snapshot.data![index].amountPaid!.toString(),
                                                    style: GoogleFonts.getFont(
                                                        'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15
                                                    ),)
                                                ],
                                              ),
                                              Text('In Process',
                                                style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.green
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                  );
                }
              } else {
                return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(child: CircularProgressIndicator(
                            color: Colors.blue
                        ),)
                      ],
                    )
                );
              }
              return Expanded(child:
              Container(
                alignment: Alignment.center,
                child: Text('No active orders',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: const Color(0xFFF83F3F),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    )),
              ));
            })
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