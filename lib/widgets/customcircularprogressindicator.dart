import 'package:flutter/material.dart';
import 'package:login/helpers/constant.dart' as Constant;

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.black,
      valueColor: new AlwaysStoppedAnimation<Color>(Constant.primaryColor),
    ));
  }
}
