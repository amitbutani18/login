import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi with ChangeNotifier {
  Future<int> signIn(String email, String password) async {
    final response = await http.post(
      'http://13.234.34.241:3000/API/signin',
      body: {
        "email": email,
        "password": password,
        "deviceid": "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "devicetype": "1",
        "fcm_token": "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      },
    );
    Map<dynamic, dynamic> map = json.decode(response.body);
    print(map);
    if (response.body.contains("err")) {
      final err = map['err'];
      print(err);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        if (map.containsKey('data')) {
          print(map['data']);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setBool('login', true);
          sharedPreferences.setString('name', map['data']['name']);
          sharedPreferences.setString('email', map['data']['email']);

          print(sharedPreferences.getString('name'));
          print(sharedPreferences.getString('email'));
          print(sharedPreferences.getBool('login'));
        }
      } else {
        throw Exception("fail to load");
      }
    }

    return response.statusCode;
  }
}
