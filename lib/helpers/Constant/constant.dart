library constant;

import 'package:flutter/material.dart';

const apiLink = "http://3.23.114.34:3000/API/";
const imageLink = "http://3.23.114.34:3000/";
const Color primaryColor = Color(0xFFFFD54F); // Colors.amber[300]

//Error Msg
const emailMsg = 'Please enter valid email';
const passwordMsg = 'Please enter valid password';
const nameMsg = 'Please enter valid name';
const validPin = 'Please enter valid pin';
const pinMsg = 'Pin must be 4 digit';
const pinCompareMsg = 'Please enter same pin';
const samePassMsg = 'Please enter same password';
const userNameMsg = 'Username must be not empty';
const titleMsg = 'Please enter title';
const linkMsg = 'Please enter link';

// Device Size
const divSize = 550;

class GetConstant {
  // singleton
  static final GetConstant _singleton = GetConstant._internal();
  factory GetConstant() => _singleton;
  GetConstant._internal();
  static GetConstant get shared => _singleton;

  ThemeData themeData(BuildContext context) {
    return ThemeData.dark().copyWith(
      accentColor: Color.fromRGBO(201, 163, 66, 1),
      canvasColor: Color.fromRGBO(201, 163, 66, 1),
      backgroundColor: Color.fromRGBO(201, 163, 66, 1),
      buttonTheme: ButtonThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
            ),
      ),
    );
  }

  Text text(
      {@required String text,
      double fontSize = 20,
      Color color = Colors.white,
      FontWeight fontWeight = FontWeight.normal,
      double letterSpacing = 1}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
  }

  static Container customContainerForDivideValueInList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 1,
      height: 10,
      color: Colors.grey,
    );
  }

  static Container customVerticalDivider(double height) {
    return Container(
      height: height / 2,
      width: 3,
      color: Colors.amber.withOpacity(.5),
    );
  }
}
