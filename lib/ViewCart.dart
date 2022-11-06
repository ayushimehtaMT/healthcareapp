import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/CartItemModel.dart';
import 'package:healthcareapp/CartProvider.dart';
import 'package:healthcareapp/DbHelper.dart';
import 'package:healthcareapp/LandingActivity.dart';
import 'package:healthcareapp/SearchMedicine.dart';
import 'package:provider/provider.dart';

class ViewCartWidget extends StatefulWidget {
  const ViewCartWidget({Key? key}) : super(key: key);

  @override
  _ViewCartWidgetState createState() => _ViewCartWidgetState();
}

class _ViewCartWidgetState extends State<ViewCartWidget> {

  static const List<Widget> _widgetOptions = <Widget>[
    LandingActivity(),
    SearchMedicine(),
    ViewCartWidget()
  ];

  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
          child: Text(
            'Cart',
            style: GoogleFonts.getFont(
              'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        )
      ),
      body: Column(
        children: [
          FutureBuilder(future: cart.getCartData(),
              builder: (context, AsyncSnapshot<List<CartItem>> snapshot) {
            // if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
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
                                      Expanded(child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].productName.toString(),
                                              style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17
                                              ),
                                            ),
                                            const SizedBox(height: 18,),
                                            InkWell(onTap: () {
                                              cart.updateCart(snapshot.data!, snapshot.data![index].id!, false, true);
                                            }, child: Icon(Icons.delete_forever_rounded)),
                                          ],
                                        ),
                                      )),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text('₹',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                ),),
                                              Text((snapshot.data![index].quantity! * snapshot.data![index].price!).toString(),
                                                style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                ),)
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            // mainAxisSize: MainAxisSize.max,
                                            children: [
                                              InkWell(onTap: () {
                                                cart.updateCart(snapshot.data!, snapshot.data![index].id!, false, false);
                                              },
                                                  child: const Icon(Icons.do_disturb_on_outlined,
                                                    color: Color(0xFFF83F3F),
                                                  )),
                                              const SizedBox(width: 10,),
                                              Container(
                                                width: 27,
                                                child: Text(snapshot.data![index].quantity.toString(),
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              InkWell(onTap: () {
                                                cart.updateCart(snapshot.data!, snapshot.data![index].id!, true, false);
                                              },
                                                  child: const Icon(Icons.add_circle,
                                                    color: Color(0xFFF83F3F),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                );
              }
              return Expanded(child:
              Container(
                alignment: Alignment.center,
                child: Text('Your cart is empty',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: const Color(0xFFF83F3F),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    )),
              ));
            // } else {
            //   return const Center(child: CircularProgressIndicator(),);
            // }


          }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Row(
              children: [
                Expanded(child:
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 8.0, right: 8.0, bottom: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Payable',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            const Text('₹',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 23,
                              ),),
                            Text(value.getTotalPrice().toStringAsFixed(2),
                              style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                              ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                    child: SizedBox(
                      height: 35,
                      width: 100,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: cart.getTotalPrice() > 0 ? () => {
                          cart.placeOrder(),
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Your order has been placed!'),
                          )),

                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                              const LandingActivity(),
                            ),
                          ),
                        } : null,
                        child: Text(
                          'Place Order',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 10,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                _widgetOptions.elementAt(index),
            ),
          );
        },
        currentIndex: 2,
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

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.subtitle2,),
          Text(value.toString(), style: Theme.of(context).textTheme.subtitle2,),
        ],
      ),
    );
  }
}
