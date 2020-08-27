import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterApi with ChangeNotifier {
  Future<List<dynamic>> signUp(
      String name, String email, String password) async {
    final response = await http.post('http://15.207.228.103:3000/API/signup',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "name": name,
          "password": password,
          "deviceid": "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
          "devicetype": 1,
          "fcm_token": "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }));
    Map<dynamic, dynamic> map = json.decode(response.body);
    print(map);
    if (map.containsKey('err')) {
      print(map['err']);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        print(map['data']);
      } else {
        throw Exception("Fail To Load");
      }
    }

    return [response.statusCode, map['data']];
  }
}
