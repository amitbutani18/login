import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class DatePick extends StatefulWidget {
  @override
  _DatePickState createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  DateTime _dateTime;
  TimeOfDay _timeOfDay;
  DateTime _firstDate;
  DateTime _lastDate;
  double divSize = 470;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.height > divSize ? 320 : 200,
              height: size.height > divSize ? 80 : 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.transparent,
                child: ListTile(
                  title: Padding(
                    padding: size.height > divSize
                        ? const EdgeInsets.only(top: 0.0)
                        : const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _firstDate == null && _lastDate == null
                          ? 'No date choosen! '
                          : 'First Date : ${DateFormat().add_yMd().format(_firstDate)}  Last Date : ${DateFormat().add_yMd().format(_lastDate)}',
                      style: TextStyle(
                          fontSize: size.height > divSize ? 20 : 10,
                          color: Colors.white),
                    ),
                  ),
                  trailing: ClipOval(
                    child: Container(
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.white, Colors.amberAccent]),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.blue,
                          child: SizedBox(
                              width: size.height > divSize ? 50 : 30,
                              height: size.height > divSize ? 50 : 30,
                              child: Icon(
                                Icons.calendar_today,
                                size: size.height > divSize ? 20 : 15,
                                color: Colors.black,
                              )),
                          onTap: () async {
                            List<DateTime> dateTime =
                                await DateRangePicker.showDatePicker(
                                    context: context,
                                    initialFirstDate: DateTime.now(),
                                    initialLastDate: DateTime.now().add(
                                      Duration(days: 7),
                                    ),
                                    firstDate: DateTime.now()
                                        .subtract(Duration(days: 1)),
                                    lastDate:
                                        DateTime(DateTime.now().year + 5));
                            if (dateTime != null && dateTime.length == 2) {
                              setState(() {
                                _firstDate = dateTime[0];
                                _lastDate = dateTime[1];
                              });
                              print(dateTime);
                            }
                            // DateTime datetime = await showRoundedDatePicker(
                            //         context: context,
                            //         initialDate: DateTime.now(),
                            //         firstDate:
                            //             DateTime.now().subtract(Duration(days: 1)),
                            //         lastDate: DateTime(DateTime.now().year + 1),
                            //         borderRadius: 16,
                            //         theme: ThemeData.dark())
                            //     .then((pickdate) {
                            //   if (pickdate == null) {
                            //     return;
                            //   }
                            //   setState(() {
                            //     _dateTime = pickdate;
                            //   });
                            // });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   width: 350,
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15.0),
            //     ),
            //     color: Colors.green[100],
            //     child: ListTile(
            //       title: Text(_timeOfDay == null
            //           ? 'No Time choosen! '
            //           : ' Picked Time : ${_timeOfDay.format(context)}'),
            //       trailing: RaisedButton(
            //         splashColor: Colors.pink[300],
            //         animationDuration: Duration(seconds: 1),
            //         color: Colors.greenAccent,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Text(_timeOfDay == null ? 'Choose ' : "Change"),
            //         onPressed: () async {
            //           await showRoundedTimePicker(
            //                   context: context,
            //                   initialTime: TimeOfDay.now(),
            //                   borderRadius: 16,
            //                   theme: ThemeData.dark())
            //               .then((pickdate) {
            //             if (pickdate == null) {
            //               return;
            //             }
            //             setState(() {
            //               _timeOfDay = pickdate;
            //             });
            //           });
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
