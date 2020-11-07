import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/helpers/Constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProjectProvider with ChangeNotifier {
  Future<void> addProject({
    String what,
    String where,
    String dateTime,
    String rate,
    String address,
    String link,
    String usages,
    String notes,
  }) async {
    print(what);
    print(where);
    print(dateTime);
    print(rate);
    print(address);
    print(link);
    print(usages);
    print(notes);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    print(userId);
    final response = await http.post(
      '${apiLink}addproject',
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "userid": userId,
        "what": what,
        "where": where,
        "when": dateTime,
        "address": address,
        "price": rate,
        "members": [
          {"userid": "5f68dddf8c50765e9a3b5a44", "status": 0},
          {"userid": "5f68dddf8c50765e9a3b5a44", "status": 0}
        ],
        "link": link,
        "usages": usages,
        "notes": notes,
        "status": 1
      }),
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
