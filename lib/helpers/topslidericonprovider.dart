import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/slidericon.dart';

class TopSliderIconProvider with ChangeNotifier {
  List<SliderIcon> _items = [
    SliderIcon(image: 'assets/icons/AddProject.png'),
    SliderIcon(image: 'assets/icons/read.png'),
    SliderIcon(image: 'assets/icons/add.png'),
    SliderIcon(image: 'assets/icons/Hired.png'),
    SliderIcon(image: 'assets/icons/AddProject.png'),
    SliderIcon(image: 'assets/icons/AddProject.png'),
    SliderIcon(image: 'assets/icons/read.png'),
    SliderIcon(image: 'assets/icons/add.png'),
    SliderIcon(image: 'assets/icons/Hired.png'),
    SliderIcon(image: 'assets/icons/AddProject.png'),
  ];
  List<SliderIcon> get items {
    return [..._items];
  }
}
