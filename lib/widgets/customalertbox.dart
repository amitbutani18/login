import 'package:flutter/material.dart';

class CustomAlertBox {
  static final CustomAlertBox _singleton = CustomAlertBox._internal();
  factory CustomAlertBox() => _singleton;
  CustomAlertBox._internal();
  static CustomAlertBox get shared => _singleton;

  void showMyDialog({
    BuildContext context,
    Function getImageFromCam,
    Function getImageFromGal,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Pick Photo",
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Color.fromRGBO(37, 36, 41, 1),
          content: Container(
            height: 100,
            width: 200,
            child: Column(
              children: [
                GestureDetector(
                  onTap: getImageFromCam,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Text(
                      "Camera",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white24,
                ),
                GestureDetector(
                  onTap: getImageFromGal,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      "Gallery",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
