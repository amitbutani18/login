import 'package:flutter/material.dart';

class ServiceProvider extends StatelessWidget {
  InputDecoration _textDecoration(String lable, double fontSize, Icon icon) {
    return InputDecoration(
      hintText: lable,
      hintStyle: TextStyle(color: Colors.grey, height: 1, fontSize: fontSize),
      icon: ClipOval(
        child: Container(
          decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white,
                  Colors.amber,
                ]),
            borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
          ),
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
                width: fontSize == 30 ? 50 : 30,
                height: fontSize == 30 ? 50 : 30,
                child: Center(child: icon)),
          ),
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.yellow),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
