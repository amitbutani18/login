import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:login/helpers/images.dart';

class ImagesProvider with ChangeNotifier {
  List<Images> _items = [
    Images(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/OYO_Rooms_%28logo%29.png/1200px-OYO_Rooms_%28logo%29.png',
    ),
    Images(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/OYO_Rooms_%28logo%29.png/1200px-OYO_Rooms_%28logo%29.png',
    ),
    Images(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/OYO_Rooms_%28logo%29.png/1200px-OYO_Rooms_%28logo%29.png',
    ),
    Images(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/OYO_Rooms_%28logo%29.png/1200px-OYO_Rooms_%28logo%29.png',
    ),
    Images(
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/OYO_Rooms_%28logo%29.png/1200px-OYO_Rooms_%28logo%29.png',
    ),
  ];
  List<Images> get items {
    return [..._items];
  }
}
