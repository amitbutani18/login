import 'package:flutter/material.dart';
import 'package:login/helpers/project.dart';

class ProjectProvider with ChangeNotifier {
  List<Project> _items = [];
  List<Project> get items {
    return [..._items];
  }

  void addProject(
    String what,
    String where,
    DateTime dateTime,
    double rate,
    String who,
    String link,
    String usages,
    String notes,
  ) {
    _items.add(Project(
        what: what,
        where: where,
        dateTime: dateTime,
        rate: rate,
        who: who,
        link: link,
        usages: usages,
        notes: notes));
  }
}
