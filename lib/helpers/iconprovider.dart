import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/icons.dart';

class IconProvider with ChangeNotifier {
  List<Iconss> _items = [
    Iconss(icon: Icon(Icons.ac_unit)),
    Iconss(icon: Icon(Icons.memory)),
    Iconss(icon: Icon(Icons.label)),
    Iconss(icon: Icon(Icons.portrait)),
    Iconss(icon: Icon(Icons.pan_tool)),
    Iconss(icon: Icon(Icons.power)),
    Iconss(icon: Icon(Icons.list)),
    Iconss(icon: Icon(Icons.category)),
    Iconss(icon: Icon(Icons.access_alarms)),
    Iconss(icon: Icon(Icons.access_time)),
    Iconss(icon: Icon(Icons.accessibility)),
    Iconss(icon: Icon(Icons.account_balance)),
  ];
  List<Iconss> get items {
    return [..._items];
  }
}
