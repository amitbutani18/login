import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/slidericon.dart';

class BottomDownSliderProvider with ChangeNotifier {
  List<SliderIcon> _items = [
    SliderIcon(
        title: 'Electronics', image: 'assets/icons/Electronicsbottom.png'),
    SliderIcon(title: 'Electronics', image: 'assets/icons/Clothesbottom.png'),
    SliderIcon(title: 'Electronics', image: 'assets/icons/jewellarybottom.png'),
    // SliderIcon(image: 'assets/icons/Goibibo.png'),
    // SliderIcon(image: 'assets/icons/Expedia.png'),
    // SliderIcon(image: 'assets/icons/Hotels.png'),
    // SliderIcon(image: 'assets/icons/gym.png'),
    // SliderIcon(image: 'assets/icons/retaurant.png'),
    // SliderIcon(image: 'assets/icons/Hotels.png'),
  ];
  List<SliderIcon> get items {
    return [..._items];
  }
}
