import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/slidericon.dart';
import 'package:http/http.dart' as http;

class RightSideSliderIconProvider with ChangeNotifier {
  List<SliderIcon> _items = [
    // SliderIcon(title: 'Electronics', image: 'assets/icons/Electronics.png'),
    // SliderIcon(title: 'Jewellary', image: 'assets/icons/Jewellary.png'),
    // SliderIcon(title: 'Clothes', image: 'assets/icons/Clothes.png'),
  ];
  List<SliderIcon> get items {
    return [..._items];
  }

  Future<void> setIcon() async {
    try {
      final response = await http.post(
        'http://15.207.228.103:3000/API/companyandservicelist',
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "userid": "5f449a9036eb3907c617d369",
            "type": 1,
          },
        ),
      );
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> list = map["data"];
      print(list.length);
      List<SliderIcon> loadedList = [];

      for (var i = 0; i < list.length / 2; i++) {
        loadedList.add(
          SliderIcon(
              title: '${list[i]['name']}',
              image: 'assets/icons/${list[i]['image']}.png'),
        );
        print(list[i]);
      }
      _items = loadedList;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
