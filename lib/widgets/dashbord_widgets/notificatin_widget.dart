import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/notification_provider.dart';
import 'package:login/helpers/Constant/constant.dart';
import 'package:provider/provider.dart';

class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 40,
          right: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              // width: 450,
              child: Text(
                "NOTIFICATIONS",
                style: TextStyle(
                    fontSize: height > divSize ? 22 : 18,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Consumer<NotificationProvider>(
                builder: (context, notificationObj, ch) => LimitedBox(
                  maxHeight: height / 2,
                  // maxWidth: 430,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) => Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.4),
                          // border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5, right: 15, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                        notificationObj
                                            .notificationList[i].imageUrl,
                                        fit: BoxFit.contain,
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notificationObj
                                              .notificationList[i].title,
                                          style: TextStyle(color: primaryColor),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: Text(
                                            notificationObj
                                                .notificationList[i].subTitle,
                                            style:
                                                TextStyle(color: Colors.grey),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              DateFormat("hh-mm").format(
                                  notificationObj.notificationList[i].time),
                              style: TextStyle(color: Colors.grey),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                    itemCount: notificationObj.notificationList.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
