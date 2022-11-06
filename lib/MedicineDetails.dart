import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/CartProvider.dart';
import 'package:healthcareapp/LandingActivity.dart';
import 'package:healthcareapp/MedicineModel.dart';
import 'package:healthcareapp/PreviousOrderModel.dart';
import 'package:healthcareapp/PreviousOrdersProvider.dart';
import 'package:healthcareapp/Search.dart';
import 'package:healthcareapp/SearchMedicine.dart';
import 'package:healthcareapp/ViewCart.dart';
import 'package:provider/provider.dart';

class MedicineDetails extends StatefulWidget {
  final Medicine data;

  MedicineDetails({super.key, required this.data});

  @override
  State<MedicineDetails> createState() => MedicineDetailsState(data);
}

class MedicineDetailsState extends State<MedicineDetails>{
  final Medicine data;
  bool isLoading = true;

  static const List<Widget> _widgetOptions = <Widget>[
    LandingActivity(),
    SearchMedicine(),
    ViewCartWidget()
  ];

  MedicineDetailsState(this.data);

  CartProvider cartProvider = CartProvider();
  // void startTimer() {
  //   Timer.periodic(const Duration(seconds: 2), (t) {
  //     setState(() {
  //       isLoading = false; //set loading to false
  //     });
  //     t.cancel(); //stops the timer
  //   });
  // }
  //
  // @override
  // void initState() {
  //   startTimer();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
          child: Text(
            'Medicine Details',
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
          const SizedBox(height: 40,),
          Card(
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
                          Text('Medicine Name',
                            style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            ),
                          ),
                          Text('Description',
                            style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            ),
                          ),
                          Text('Price',
                            style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            ),
                          ),
                          const SizedBox(height: 20,),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (BuildContext context) =>
                                    const SearchMedicine(),
                                ));
                              // previousOrdersProvider.refill(snapshot.data![index].id!);
                            },
                            child: Text(
                              'Cancel',
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
                      Expanded(child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(data.productName!,
                              style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15
                              ),
                            ),
                            Text(data.description!,
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
                                Text(data.price!.toString(),
                                  style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15
                                  ),)
                              ],
                            ),
                            const SizedBox(height: 20,),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                              ),
                              onPressed: data.quantity! == 0 ? null : () {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Your cart has been updated!'),
                                ));
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (BuildContext context) =>
                                  const SearchMedicine(),
                                ));
                                cartProvider.addToCart(data!);
                              },
                              child: Text(
                                'Add To Cart',
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
                  ),
                ]
              )
            )
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