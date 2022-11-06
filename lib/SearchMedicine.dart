import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/LandingActivity.dart';
import 'package:healthcareapp/PreviousOrderModel.dart';
import 'package:healthcareapp/PreviousOrdersProvider.dart';
import 'package:healthcareapp/ViewCart.dart';
import 'package:provider/provider.dart';

class SearchMedicine extends StatefulWidget {
  const SearchMedicine({super.key});

  @override
  State<SearchMedicine> createState() => SearchMedicineState();
}

class SearchMedicineState extends State<SearchMedicine>{
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
    final previousOrdersProvider = Provider.of<PreviousOrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
          child: Text(
            'Search',
            style: GoogleFonts.getFont(
              'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 140,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 20,),
              Text(
                  'My Orders',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  )
              ),
              const SizedBox(width: 10,),
              Text(
                  '(Showing last 3 orders...)',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 10,
                  )
              ),
            ],
          ),
          FutureBuilder(future: previousOrdersProvider.getPreviousOrders(),
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
                                          const SizedBox(height: 45,),
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
                                            const SizedBox(height: 10,),
                                            TextButton(
                                              style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                              ),
                                              onPressed: () {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text('Your cart has been updated!'),
                                                ));
                                                previousOrdersProvider.refill(snapshot.data![index].id!);
                                              },
                                              child: Text(
                                                'Refill',
                                                style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
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
              child: Text('No previous orders',
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
        currentIndex: 1,
        selectedItemColor: const Color(0xFFF83F3F),
      ),
    );
  }
}