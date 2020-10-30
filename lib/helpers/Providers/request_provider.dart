import 'package:flutter/material.dart';

class SendRequest {
  final String title, userName, location;
  final DateTime time;
  final double rate;

  SendRequest(
      {@required this.location,
      @required this.title,
      @required this.rate,
      @required this.userName,
      @required this.time});
}

class RecieveRequest {
  final String title, location;

  final DateTime time;

  RecieveRequest(
      {@required this.location, @required this.time, @required this.title});
}

class RequestProvider with ChangeNotifier {
  List<SendRequest> _sendRequestList = [
    SendRequest(
        location: 'London',
        title: 'Project Name 4',
        userName: 'Kapil maheshvari',
        rate: 20.0,
        time: DateTime.now()),
    SendRequest(
        location: 'London',
        title: 'Project Name 3',
        userName: 'Kapil maheshvari',
        rate: 20.0,
        time: DateTime.now()),
    SendRequest(
        location: 'London',
        title: 'Project Name 2',
        userName: 'Kapil maheshvari',
        rate: 20.0,
        time: DateTime.now()),
    SendRequest(
        location: 'London',
        title: 'Project Name 1',
        userName: 'Kapil maheshvari',
        rate: 20.0,
        time: DateTime.now()),
    SendRequest(
        location: 'London',
        title: 'Project Name 8',
        userName: 'Kapil maheshvari',
        rate: 20.0,
        time: DateTime.now()),
  ];

  List<SendRequest> get sendRequest {
    return [..._sendRequestList];
  }

  List<RecieveRequest> _reciveRequestList = [
    RecieveRequest(
        location: 'London', title: 'Project Name 4', time: DateTime.now()),
    RecieveRequest(
        location: 'London', title: 'Project Name 4', time: DateTime.now()),
    RecieveRequest(
        location: 'London', title: 'Project Name 4', time: DateTime.now()),
    RecieveRequest(
        location: 'London', title: 'Project Name 4', time: DateTime.now()),
    RecieveRequest(
        location: 'London', title: 'Project Name 4', time: DateTime.now()),
    RecieveRequest(
        location: 'London', title: 'Project Name 4', time: DateTime.now()),
  ];

  List<RecieveRequest> get reciveRequest {
    return [..._reciveRequestList];
  }
}
