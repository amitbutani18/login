import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/icons.dart';
import 'package:login/helpers/constant.dart' as Constant;

class IconProvider with ChangeNotifier {
  List<Iconss> _items = [
    Iconss(
        icon: Icon(
      Icons.ac_unit,
      color: Constant.primaryColor,
      size: 13,
    )),
    Iconss(
        icon: Icon(
      Icons.memory,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.label,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.portrait,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.pan_tool,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.power,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.list,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.category,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.access_alarms,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.access_time,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.accessibility,
      color: Constant.primaryColor,
    )),
    Iconss(
        icon: Icon(
      Icons.account_balance,
      color: Constant.primaryColor,
    )),
  ];
  List<Iconss> get items {
    return [..._items];
  }
}
