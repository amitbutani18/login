import 'package:flutter/material.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;
import 'package:login/screens/projectDetails.dart';

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
        child: CustomCircleAvatarForIcon(image: image),
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

class CustomCircleAvatarForIcon extends StatelessWidget {
  final double radius;
  const CustomCircleAvatarForIcon({
    Key key,
    this.radius = 10.0,
    @required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      child: Image.asset(image),
    );
  }
}
