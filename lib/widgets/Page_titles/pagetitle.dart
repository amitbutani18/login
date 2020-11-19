import 'package:flutter/material.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class PageTitle extends StatelessWidget {
  const PageTitle(
      {Key key, @required this.size, @required this.title, this.callback})
      : super(key: key);

  final Size size;
  final Function callback;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: callback == null
              ? () {
                  Navigator.of(context).pop();
                }
              : callback,
          child: Container(
              padding: EdgeInsets.only(top: 10),
              height: size.width < 600 ? 25 : 30,
              width: size.width < 600 ? 25 : 30,
              child: Image.asset('assets/icons/backicon.png')),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Constant.primaryColor,
                    fontSize: size.width < 600 ? 15 : 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
