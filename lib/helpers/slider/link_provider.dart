import 'package:flutter/cupertino.dart';

class ULink {
  final String id;
  final String title;
  final String link;
  bool init;

  ULink({this.id, this.title, this.link, this.init});
}

class LinkProvider with ChangeNotifier {
  List<ULink> _items = [];

  List<ULink> get items {
    return [..._items];
  }

  void updateLinks(List<ULink> list) {
    _items = list;
    notifyListeners();
  }
}
