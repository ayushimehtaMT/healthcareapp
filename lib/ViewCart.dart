import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcareapp/CartItemModel.dart';
import 'package:healthcareapp/CartProvider.dart';
import 'package:healthcareapp/DbHelper.dart';
import 'package:provider/provider.dart';

class ViewCartWidget extends StatefulWidget {
  const ViewCartWidget({Key? key}) : super(key: key);

  @override
  _ViewCartWidgetState createState() => _ViewCartWidgetState();
}

class _ViewCartWidgetState extends State<ViewCartWidget> {
  final DbHelper dbHelper = DbHelper();
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
          child: Text(
            'Cart',
            style: GoogleFonts.getFont(
              'Poppins',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(future: cart.getCartData(),
              builder: (context, AsyncSnapshot<List<CartItem>> snapshot) {
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
                                          dbHelper.deleteCartItem(snapshot.data![index].id!).then((value){
                                            cart.subtractFromTotalPrice(double.parse(
                                                (snapshot.data![index].quantity! * snapshot.data![index].price!).toString()));
                                          });
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
                                              fontSize: 25,
                                            ),),
                                          Text((snapshot.data![index].quantity! * snapshot.data![index].price!).toString(),
                                            style: GoogleFonts.getFont(
                                                'Poppins',
                                                fontSize: 20
                                            ),)
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        // mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(onTap: () {
                                            int quantity = snapshot.data![index].quantity!;
                                            quantity--;
                                            dbHelper!.updateQuantity(
                                                CartItem(id: snapshot.data![index].id,
                                                    productId: snapshot.data![index].productId,
                                                    productName: snapshot.data![index].productName,
                                                    price: snapshot.data![index].price!,
                                                    quantity: quantity)
                                            ).then((value) {
                                              cart.subtractFromTotalPrice(double.parse(snapshot.data![index].price!.toString()));
                                            });
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
                                            int quantity = snapshot.data![index].quantity!;
                                            quantity++;
                                            dbHelper!.updateQuantity(
                                              CartItem(id: snapshot.data![index].id,
                                                  productId: snapshot.data![index].productId,
                                                  productName: snapshot.data![index].productName,
                                                  price: snapshot.data![index].price!,
                                                  quantity: quantity)
                                            ).then((value) {
                                              cart.addToTotalPrice(double.parse(snapshot.data![index].price!.toString()));
                                            });
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
                                fontSize: 25,
                              ),),
                            Text(value.getTotalPrice().toStringAsFixed(2),
                              style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontSize: 20
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
                    child: ElevatedButton(
                      onPressed: cart.getTotalPrice() > 0 ? () => { } : null,
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF6FF5E5)),
                      //   textStyle: MaterialStateTextStyle.resolveWith((states) => TextStyle(color: Color(0xFF000000))),
                      // ),
                      child: const Text('Checkout'),
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
          // setState(() {
          //   _selectedIndex = index;
          // });
        },
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
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
