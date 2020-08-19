import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/slidericon.dart';

class LeftSideSliderIconProvider with ChangeNotifier {
  List<SliderIcon> _items = [
    SliderIcon(image: 'assets/icons/gym.png'),
    SliderIcon(image: 'assets/icons/retaurant.png'),
    SliderIcon(image: 'assets/icons/Hotels.png'),
    SliderIcon(image: 'assets/icons/gym.png'),
    SliderIcon(image: 'assets/icons/retaurant.png'),
    SliderIcon(image: 'assets/icons/Hotels.png'),
    SliderIcon(image: 'assets/icons/gym.png'),
    SliderIcon(image: 'assets/icons/retaurant.png'),
    SliderIcon(image: 'assets/icons/Hotels.png'),
  ];
  List<SliderIcon> get items {
    return [..._items];
  }
}
