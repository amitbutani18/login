import 'package:flutter/cupertino.dart';

class DashBoardMethods with ChangeNotifier {
  String _getDashboardWidgetTag = '';
  String _whatValue = '', _location = '', _firstDate = '', _lastDate = '';

  String get getDashboardWidgetTag {
    return _getDashboardWidgetTag;
  }

  String get whatValue {
    return _whatValue;
  }

  String get location {
    return _location;
  }

  String get firstDate {
    return _firstDate;
  }

  String get lastDate {
    return _lastDate;
  }

  changeDashboardWidget(String tag) {
    _getDashboardWidgetTag = tag;
    notifyListeners();
  }

  changeWhatValue(String value) {
    print(value);
    _whatValue = value;
    notifyListeners();
  }

  changeWhereValue(String value) {
    print(value);
    _location = value;
    notifyListeners();
  }

  changeFirstDate(String date) {
    _firstDate = date;
    notifyListeners();
  }

  changeLastDate(String date) {
    _lastDate = date;
    notifyListeners();
  }
}
