import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi with ChangeNotifier {
  Future<Map> getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final api = sharedPreferences.getString('api');
    final userId = sharedPreferences.getString('userid');
    final response = await http.post('${api}getprofile',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "userid": userId,
        }));
    Map<dynamic, dynamic> map = json.decode(response.body);
    print(map);
    if (map.containsKey('err')) {
      print(map['err']);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        print(map['data']);
        return map['data'];
      } else {
        throw "Fail To Load";
      }
    }
  }

  Future<void> updateProWithimg(String name, String ytLink, String lkdinLink,
      String location, File image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final api = sharedPreferences.getString('api');
    final userId = sharedPreferences.getString('userid');
    final bytes = File(image.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    print(img64);
    final response = await http.post(
      '${api}updateprofile',
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "userid": userId,
        "profileimg": img64,
        "name": name,
        "youtube": ytLink,
        "linkdin": lkdinLink,
        "location": location,
      },
    );
    Map<dynamic, dynamic> map = json.decode(response.body);
    print(map);
    if (map.containsKey('err')) {
      print("Error Occured");
      print(map['err']);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        print(map['data']);
      } else {
        throw "Fail to load";
      }
    }
  }

  Future<void> updatePro(
      String name, String ytLink, String lkdinLink, String location) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final api = sharedPreferences.getString('api');
    final userId = sharedPreferences.getString('userid');
    final response = await http.post(
      '${api}updateprofile',
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "userid": userId,
        "name": name,
        "youtube": ytLink,
        "linkdin": lkdinLink,
        "location": location,
      },
    );
    Map<dynamic, dynamic> map = json.decode(response.body);
    print(map);
    if (map.containsKey('err')) {
      print("Error Occured");
      print(map['err']);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        print(map['data']);
      } else {
        throw "Fail to load";
      }
    }
  }
}
