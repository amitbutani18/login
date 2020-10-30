import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/slider/slidericon.dart';

class TopSliderIconProvider with ChangeNotifier {
  List<SliderIcon> _items = [
    SliderIcon(title: 'addProject', image: 'assets/icons/AddProject.png'),
    SliderIcon(title: 'add', image: 'assets/icons/add.png'),
    SliderIcon(title: 'dashboard', image: 'assets/icons/dashboard.png'),
    SliderIcon(title: 'hired', image: 'assets/icons/Hired.png'),
    SliderIcon(
        title: 'pendingRequest', image: 'assets/icons/pendingRequest.png'),
    SliderIcon(title: 'notifications', image: 'assets/icons/notifications.png'),
    SliderIcon(title: 'allRequest', image: 'assets/icons/allRequest.png'),
  ];
  List<SliderIcon> get items {
    return [..._items];
  }

  List<SliderIcon> _images = [
    SliderIcon(
        title: 'Electronics', image: 'assets/icons/selectedaddProject.png'),
    SliderIcon(
        title: 'Electronics', image: 'assets/icons/selectedaddProject.png'),
    SliderIcon(
        title: 'Electronics', image: 'assets/icons/selectedaddProject.png'),
    SliderIcon(
        title: 'Electronics', image: 'assets/icons/selectedaddProject.png'),
    SliderIcon(
        title: 'Electronics', image: 'assets/icons/selectedaddProject.png'),
    SliderIcon(
        title: 'Electronics', image: 'assets/icons/selectedaddProject.png'),
    SliderIcon(
        title: 'Electronics', image: 'assets/icons/selectedaddProject.png'),
  ];
  List<SliderIcon> get images {
    return [..._images];
  }
}
