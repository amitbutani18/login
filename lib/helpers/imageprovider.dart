import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:login/helpers/images.dart';

class ImagesProvider with ChangeNotifier {
  List<Images> _items = [
    Images(imageUrl: 'assets/images/oyoimg.png', offer: '10% OFF'),
    Images(imageUrl: 'assets/images/Makemytripimg.png', offer: '20% OFF'),
    Images(imageUrl: 'assets/images/expediaimg.png', offer: '10% OFF'),
    Images(imageUrl: 'assets/images/bookingimg.png', offer: '50% OFF'),
  ];
  List<Images> get items {
    return [..._items];
  }
}
