import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:login/helpers/images.dart';

class ImagesProvider with ChangeNotifier {
  List<Images> _items = [
    Images(
      imageUrl:
          'https://economictimes.indiatimes.com/thumb/msid-68402418,width-1200,height-900,resizemode-4,imgsize-43030/makemytrip-agencies.jpg?from=mdr',
    ),
    Images(
      imageUrl:
          'https://www.logolynx.com/images/logolynx/09/097df07a639e94c3d2e31db93df9aae1.jpeg',
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
