import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/helpers/constant.dart' as Constant;

class RegisterApi with ChangeNotifier {
  Future<List<dynamic>> signUp(
      String name, String email, String password, String companyName) async {
    final response = await http.post('${Constant.apiLink}signup',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "name": name,
          "password": password,
          "company_name": companyName,
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
