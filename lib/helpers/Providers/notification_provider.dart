import 'package:flutter/material.dart';

class Notification {
  final String imageUrl, title, subTitle;
  final DateTime time;

  Notification(
      {@required this.imageUrl,
      @required this.title,
      @required this.subTitle,
      @required this.time});
}

class NotificationProvider with ChangeNotifier {
  List<Notification> _notificationList = [
    Notification(
        imageUrl: 'assets/icons/Request_Acceped.png',
        title: 'Request Accepted',
        subTitle: 'Kapil maheshvari request accepted for project b.',
        time: DateTime.now()),
    Notification(
        imageUrl: 'assets/icons/Contract_End.png',
        title: 'End Contract',
        subTitle: 'Kapil maheshvari request accepted.',
        time: DateTime.now()),
    Notification(
        imageUrl: 'assets/icons/Request_Acceped.png',
        title: 'Request Accepted',
        subTitle: 'Kapil maheshvari request accepted for project b.',
        time: DateTime.now()),
    Notification(
        imageUrl: 'assets/icons/Request_Acceped.png',
        title: 'Request Accepted',
        subTitle: 'Kapil maheshvari request accepted for project b.',
        time: DateTime.now()),
    Notification(
        imageUrl: 'assets/icons/Request_Acceped.png',
        title: 'Request Accepted',
        subTitle: 'Kapil maheshvari request accepted for project b.',
        time: DateTime.now())
  ];

  List<Notification> get notificationList {
    return [..._notificationList];
  }
}
