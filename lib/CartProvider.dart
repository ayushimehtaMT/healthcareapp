import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:healthcareapp/CartItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartProvider with ChangeNotifier {

  double _totalPrice = 0.0;
  String _cartId = '';

  Future<List<CartItem>> getCartData() async {
    var response = await http.get(Uri.parse("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/carts/user_1"));

    Iterable i = json.decode(response.body)['cartItems'];
    List<CartItem> cartItems = List<CartItem>.from(i.map((e) => CartItem.fromJson(e)));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('totalPrice', 0.0 + json.decode(response.body)['totalPrice']);
    _cartId = json.decode(response.body)['id'];
    return cartItems;
  }

  void setPerfItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('totalPrice', _totalPrice);
    notifyListeners();
  }

  void getPerfItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _totalPrice = prefs.getDouble('totalPrice') ?? 0.0;
    // notifyListeners();
  }

  Future<void> updateCart(List<CartItem> cartItems, int cartItemId, bool isAdd, bool isDelete) async {
    double newTotalPrice = 0.0;
    List<CartItem> updatedCartItems = [];

    cartItems.forEach((element) {
      if (element.id == cartItemId) {
        element.quantity = element.quantity! + (isAdd! ? 1 : -1);
        if (isDelete || element.quantity == 0) {
          element.quantity = 0;
        } else {
          updatedCartItems.add(element);
        }
      } else {
        updatedCartItems.add(element);
      }

      newTotalPrice += element.quantity! * element.price!;
    });

    var body = {
      'id': _cartId,
      'totalPrice': newTotalPrice,
      'userId': 'user_1',
      'cartItems': updatedCartItems
    };

    Dio().put("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/carts/user_1", data: body)
        .then((value) => {
          notifyListeners()
        });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('totalPrice', newTotalPrice);
    getPerfItems();
    notifyListeners();
  }

  Future<void> placeOrder() async {
    var cart = await http.get(Uri.parse("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/carts/user_1"));
    Iterable i = json.decode(cart.body)['cartItems'];
    List<CartItem> items = List<CartItem>.from(i.map((e) => CartItem.fromJson(e)));

    double newTotalPrice = 0.0 + json.decode(cart.body)['totalPrice'];

    Random random = Random();
    int randNumber = random.nextInt(10000);
    var orderBody = {
      'id': 'OD$randNumber',
      'userId': 'user_1',
      'amountPaid': newTotalPrice,
      'placedAt': DateTime.now().toString(),
      'items': items
    };

    await Dio().post("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/orders", data: orderBody);

    var cartBody = {
      'id': _cartId,
      'totalPrice': 0.0,
      'userId': 'user_1',
      'cartItems': []
    };

    await Dio().put("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/carts/user_1", data: cartBody);
  }

  void subtractFromTotalPrice(double productPrice) {
    _totalPrice -= productPrice;
    setPerfItems();
    notifyListeners();
  }

  double getTotalPrice() {
    getPerfItems();
    return _totalPrice;
  }

  String getApiServer() {
    if (kIsWeb) { // ios or web
      return 'localhost';
    } else { // android
      return '10.0.2.2';
    }
  }
}