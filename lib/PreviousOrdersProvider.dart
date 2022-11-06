import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthcareapp/CartItemModel.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:healthcareapp/PreviousOrderModel.dart';

class PreviousOrdersProvider with ChangeNotifier {

  Future<List<PreviousOrder>> getPreviousOrders() async {
    var response = await http.get(Uri.parse("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/userorders/user_1"));
    Iterable i = json.decode(response.body);
    List<PreviousOrder> previousOrders = List<PreviousOrder>.from(i.map((e) => PreviousOrder.fromJson(e)));
    return previousOrders;
  }

  Future<void> refill(String orderId) async {
    var previousOrder = await http.get(Uri.parse("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/orders/$orderId"));
    Iterable i = json.decode(previousOrder.body)['items'];
    List<CartItem> items = List<CartItem>.from(i.map((e) => CartItem.fromJson(e)));

    var cart = await http.get(Uri.parse("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/carts/user_1"));
    updateCart(json.decode(cart.body)['id'], items);
  }

  Future<void> updateCart(var cartId, List<CartItem> cartItems) async {
    double newTotalPrice = 0.0;
    cartItems.forEach((element) {
      newTotalPrice += element.quantity! * element.price!;
    });

    var body = {
      'id': cartId,
      'totalPrice': newTotalPrice,
      'userId': 'user_1',
      'cartItems': cartItems
    };

    await Dio().put("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/carts/user_1", data: body);
  }

  String getApiServer() {
    if (kIsWeb) { // ios or web
      return 'localhost';
    } else { // android
      return '10.0.2.2';
    }
  }
}
