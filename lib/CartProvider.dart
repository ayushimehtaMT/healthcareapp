import 'package:flutter/cupertino.dart';
import 'package:healthcareapp/CartItemModel.dart';
import 'package:healthcareapp/DbHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartProvider with ChangeNotifier {

  DbHelper db = DbHelper();

  int _cartItemsCount = 0;
  double _totalPrice = 215.0;
  late Future<List<CartItem>> _cartItems;

  // int get cartItemsCount => _cartItemsCount;
  // double get totalPrice => _totalPrice;
  // Future<List<CartItem>> get cartItems => _cartItems;

  Future<List<CartItem>> getCartData() async {
    CartItem cartItem1 = CartItem(id: 1, productId: '1', productName: 'Cyclopalm', price: 10, quantity: 10);
    CartItem cartItem2 = CartItem(id: 2, productId: '2', productName: 'Combflam', price: 5, quantity: 5);
    CartItem cartItem3 = CartItem(id: 3, productId: '3', productName: 'ChestNCold', price: 15, quantity: 6);
    db.insert(cartItem1);
    db.insert(cartItem2);
    db.insert(cartItem3);

    _cartItems = db.getCartItems();
    return _cartItems;

    // print("Calling API");
    // var response = await http.get(Uri.parse('https://mocki.io/v1/6142a1ab-1fbf-49ba-832d-3cb80ea1304f'));
    // Iterable i = json.decode(response.body);
    // List<CartItem> cartItems = List<CartItem>.from(i.map((e) => CartItem.fromJson(e)));
    // return cartItems;
  }

  void setPerfItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartItemsCount', _cartItemsCount);
    prefs.setDouble('totalPrice', _totalPrice);
    notifyListeners();
  }

  void getPerfItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartItemsCount = prefs.getInt('cartItemsCount') ?? 0;
    _totalPrice = prefs.getDouble('totalPrice') ?? 0.0;
    // notifyListeners();
  }

  void incrementCartItemsCount() {
    _cartItemsCount++;
    setPerfItems();
    notifyListeners();
  }

  // void decrementCartItemsCount() {
  //   _cartItemsCount--;
  //   setPerfItems();
  //   notifyListeners();
  // }

  int getCartItemsCount() {
    getPerfItems();
    return _cartItemsCount;
  }

  void addToTotalPrice(double productPrice) {
    _totalPrice += productPrice;
    setPerfItems();
    notifyListeners();
  }

  void subtractFromTotalPrice(double productPrice) {
    _totalPrice -= productPrice;
    setPerfItems();
    notifyListeners();
  }

  double getTotalPrice() {
    // getPerfItems();
    return _totalPrice;
  }
}