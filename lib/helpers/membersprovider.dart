import 'package:flutter/foundation.dart';

class Member {
  final String name;
  final String secondName;
  final double amount;

  Member(
      {@required this.name, @required this.secondName, @required this.amount});
}

class MembersProvider with ChangeNotifier {
  List<Member> _items = [
    Member(name: 'Akash Gajera', secondName: 'Akash Gajera', amount: 240.00),
    Member(name: 'Akash Gajera', secondName: 'Akash Gajera', amount: 240.00),
    Member(name: 'Akash Gajera', secondName: 'Akash Gajera', amount: 240.00),
    Member(name: 'Akash Gajera', secondName: 'Akash Gajera', amount: 240.00),
    Member(name: 'Akash Gajera', secondName: 'Akash Gajera', amount: 240.00),
    Member(name: 'Akash Gajera', secondName: 'Akash Gajera', amount: 240.00),
  ];

  List<Member> get items {
    return [..._items];
  }
}
