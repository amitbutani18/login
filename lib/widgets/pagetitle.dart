import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key key,
    @required this.size,
    @required this.diviceSize,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final int diviceSize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          iconSize: size.height > diviceSize ? 50 : 30,
          icon: Icon(Icons.arrow_back),
          color: Colors.amber[200],
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.amber[200],
                  fontSize: size.height > diviceSize ? 40 : 22,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
