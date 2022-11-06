import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthcareapp/MedicineModel.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:healthcareapp/PreviousOrderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchMedicinesProvider {

  Future<List<Medicine>> getMedicines(String medicineName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse("http://${getApiServer()}:5001/wqeqwe-5708c/us-central1/medappapi/api/v1/medicines/$medicineName"));

    Iterable i = json.decode(response.body);
    List<Medicine> medicines = List<Medicine>.from(i.map((e) => Medicine.fromJson(e)));
    return medicines;
  }

  String getApiServer() {
    if (kIsWeb) { // ios or web
      return 'localhost';
    } else { // android
      return '10.0.2.2';
    }
  }
}
