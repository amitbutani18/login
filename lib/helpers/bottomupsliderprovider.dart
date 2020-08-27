import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/slidericon.dart';

class BottomUpSliderProvider with ChangeNotifier {
  List<SliderIcon> _items = [
    SliderIcon(title: 'Electronics', image: 'assets/icons/makemytrip.png'),
    SliderIcon(title: 'Electronics', image: 'assets/icons/booking.png'),
    SliderIcon(title: 'Electronics', image: 'assets/icons/oyo.png'),
    SliderIcon(title: 'Electronics', image: 'assets/icons/Goibibo.png'),
    SliderIcon(title: 'Electronics', image: 'assets/icons/Expedia.png'),
    // SliderIcon(image: 'assets/icons/Hotels.png'),
    // SliderIcon(image: 'assets/icons/gym.png'),
    // SliderIcon(image: 'assets/icons/retaurant.png'),
    // SliderIcon(image: 'assets/icons/Hotels.png'),
  ];
  List<SliderIcon> get items {
    return [..._items];
  }
}
