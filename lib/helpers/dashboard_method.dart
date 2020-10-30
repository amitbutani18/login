import 'package:flutter/cupertino.dart';

class DashBoardMethods with ChangeNotifier {
  String _getDashboardWidgetTag = '';

  String get getDashboardWidgetTag {
    return _getDashboardWidgetTag;
  }

  changeDashboardWidget(String tag) {
    _getDashboardWidgetTag = tag;
    notifyListeners();
  }
}
