import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.black,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
    ));
  }
}
