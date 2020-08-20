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

  List<SliderIcon> _images = [
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
  List<SliderIcon> get images {
    return [..._images];
  }
}
