import 'package:flutter/material.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class PageTitleWithDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  PageTitleWithDrawer({this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            scaffoldKey.currentState.openDrawer();
          },
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/icons/Sidebar.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          child: Text(
            "Service Provider",
            style: TextStyle(
              color: Constant.primaryColor,
              fontSize: 22,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/icons/home.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
