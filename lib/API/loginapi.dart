import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class LoginApi with ChangeNotifier {
  Future<List> signIn(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // final api = sharedPreferences.getString('api');

    final response = await http.post(
      '${Constant.apiLink}signin',
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
          sharedPreferences.setString("userid", map['data']['userid']);
          sharedPreferences.setInt("touchid", map['data']['touchid']);
          sharedPreferences.setInt("pinstatus", map['data']['pinstatus']);
          sharedPreferences.setInt("setpinscreen", map['data']['setpinscreen']);
          sharedPreferences.setInt(
              "serviceproviderowner", map['data']['serviceproviderowner']);
          sharedPreferences.setInt("type", map['data']['type']);

          print(sharedPreferences.getString('name'));
          print(sharedPreferences.getString('email'));
          print(sharedPreferences.getBool('login'));
          print(sharedPreferences.getString('userid'));
          print(sharedPreferences.getInt('touchid'));
          print(sharedPreferences.getInt('pinstatus'));
          print("setpinscreen  " +
              sharedPreferences.getInt('setpinscreen').toString());
          print(sharedPreferences.getInt("serviceproviderowner"));
          print("Type " + sharedPreferences.getInt("type").toString());
        }
      } else {
        throw Exception("fail to load");
      }
    }

    return [
      response.statusCode,
      map['data']['setpinscreen'],
      sharedPreferences.getInt('pinstatus')
    ];
  }

  // Forgot Password
  Future<List<dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      '${Constant.apiLink}forgotpassword',
      body: {
        "email": email,
      },
    );
    Map<dynamic, dynamic> map = json.decode(response.body);

    if (response.body.contains("err")) {
      final err = map['err'];
      print(err);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        if (map.containsKey('data')) {
          print(map["data"]);
        }
      } else {
        throw Exception("Fail To Load");
      }
    }
    return [response.statusCode, map["data"]];
  }

  //Reset Password
  Future<String> resetPassword(String currentPass, String newPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    final response = await http.post(
      '${Constant.apiLink}changepassword',
      body: {
        "userid": userId,
        "currentpassword": currentPass,
        "newpassword": newPassword
      },
    );
    Map<dynamic, dynamic> map = json.decode(response.body);

    if (response.body.contains("err")) {
      final err = map['err'];
      print(err);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        if (map.containsKey('data')) {
          print(map["data"]);
        }
      } else {
        throw Exception("Fail To Load");
      }
    }
    return map["data"];
  }
}
