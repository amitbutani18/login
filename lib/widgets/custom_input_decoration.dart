import 'package:flutter/material.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class CustomInputDecoration {
  static InputDecoration customInputDecoration(
    String lable,
    double fontSize,
    String image,
  ) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        top: 15,
      ),
      hintText: lable,
      hintStyle: TextStyle(color: Constant.primaryColor, fontSize: fontSize),
      prefixIcon: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(right: 0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 10,
          child: Image.asset(image),
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Constant.primaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Constant.primaryColor),
      ),
    );
  }
}
