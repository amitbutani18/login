import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:login/helpers/Constant/constant.dart' as Constant;
import 'package:login/helpers/dashboard_method.dart';
import 'package:provider/provider.dart';

class DatePick extends StatefulWidget {
  static const roteName = '/datepicker';
  @override
  _DatePickState createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  DateTime _firstDate;
  DateTime _lastDate;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Consumer<DashBoardMethods>(
        builder: (context, dashboardMethods, ch) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: Constant.GetConstant.shared.themeData(context),
                child: Builder(
                  builder: (context) => GestureDetector(
                    onTap: () async {
                      _firstDate = null;
                      _lastDate = null;
                      List<DateTime> dateTime =
                          await DateRangePicker.showDatePicker(
                              context: context,
                              initialFirstDate: DateTime.now(),
                              initialLastDate: DateTime.now(),
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 1)),
                              lastDate: DateTime(DateTime.now().year + 5));
                      print(dateTime[0]);
                      if (dateTime != null && dateTime.length == 1) {
                        setState(() {
                          _firstDate = dateTime[0];
                        });
                        // Change value in provider
                        dashboardMethods.changeFirstDate(
                            DateFormat("dd-MMM").format(_firstDate));
                        print(" Choose Only One date" +
                            _firstDate.toIso8601String());
                      }
                      if (dateTime != null && dateTime.length == 2) {
                        setState(() {
                          _firstDate = dateTime[0];
                          _lastDate = dateTime[1];
                        });
                        dashboardMethods.changeFirstDate(
                            DateFormat("dd-MMM").format(_firstDate));
                        dashboardMethods.changeLastDate(
                            DateFormat("dd-MMM-yyyy").format(_lastDate));

                        print(_firstDate);
                        print(_lastDate);
                      }
                      print("_firstDate");
                      print(dashboardMethods.whatValue);
                      print(dashboardMethods.location);
                    },
                    child: Container(
                      width: size.height > Constant.divSize ? 320 : 200,
                      height: size.height > Constant.divSize ? 80 : 60,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border:
                              Border(bottom: BorderSide(color: Colors.yellow))),
                      padding: EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            margin: EdgeInsets.only(right: 0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 15,
                              child: Image.asset('assets/icons/Calender.png'),
                            ),
                          ),
                          Padding(
                            padding: size.height > Constant.divSize
                                ? const EdgeInsets.only(top: 0.0)
                                : const EdgeInsets.only(top: 8.0, bottom: 5),
                            child: Text(
                              _firstDate == null && _lastDate == null
                                  ? ' ${DateFormat("dd-MMM-yyyy").format(DateTime.now())} '
                                  : _firstDate != null && _lastDate == null
                                      ? '${DateFormat("dd-MMM-yyyy").format(_firstDate)}'
                                      : '${DateFormat("dd-MMM").format(_firstDate)} | ${DateFormat("dd-MMM-yyyy").format(_lastDate)}',
                              style: TextStyle(
                                  fontSize:
                                      size.height > Constant.divSize ? 20 : 14,
                                  color: Constant.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
