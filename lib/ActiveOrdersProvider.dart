import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthcareapp/CartItemModel.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:healthcareapp/PreviousOrderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveOrdersProvider with ChangeNotifier {

  Future<List<PreviousOrder>> getActiveOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/inProgressOrders/${prefs.get('userId')}"));
    Iterable i = json.decode(response.body);
    List<PreviousOrder> previousOrders = List<PreviousOrder>.from(i.map((e) => PreviousOrder.fromJson(e)));
    return previousOrders;
  }

  String getApiServer() {
    if (kIsWeb) { // ios or web
      return 'localhost';
    } else { // android
      return '10.0.2.2';
    }
  }
}
