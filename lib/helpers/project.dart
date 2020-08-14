import 'package:flutter/foundation.dart';

class Project {
  final String what;
  final String where;
  final DateTime dateTime;
  final double rate;
  final String who;
  final String link;
  final String usages;
  final String notes;

  Project({
    @required this.what,
    @required this.where,
    @required this.dateTime,
    @required this.rate,
    @required this.who,
    @required this.link,
    @required this.usages,
    @required this.notes,
  });
}
