import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Constant/constant.dart';
import 'package:login/helpers/Providers/request_provider.dart';
import 'package:provider/provider.dart';

class AllRequestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 30, right: 10),

        // width: 450,
        // height: height / 2,
        // color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SEND REQUEST",
                      style: TextStyle(
                          fontSize: height > divSize ? 22 : 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Consumer<RequestProvider>(
                      builder: (context, requestObj, ch) => LimitedBox(
                          maxHeight: height / 2,
                          // maxWidth: 650 / 2 - 10,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomRequestTile(
                                sendRequest: requestObj.sendRequest[i],
                              ),
                            ),
                            itemCount: requestObj.sendRequest.length,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: height / 2,
              width: 3,
              color: Colors.amber.withOpacity(.5),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "RECEVIE REQUEST",
                      style: TextStyle(
                          fontSize: height > divSize ? 22 : 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Consumer<RequestProvider>(
                      builder: (context, requestObj, ch) => LimitedBox(
                          maxHeight: height / 2,
                          // maxWidth: 650 / 2 - 10,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomReciveRequestTile(
                                reciveRequest: requestObj.reciveRequest[i],
                              ),
                            ),
                            itemCount: requestObj.reciveRequest.length,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomReciveRequestTile extends StatelessWidget {
  final RecieveRequest reciveRequest;

  const CustomReciveRequestTile({
    Key key,
    this.reciveRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reciveRequest.title,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                IconTitle(
                  icon: 'assets/icons/Location_icon.png',
                  title: reciveRequest.location,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                IconTitle(
                  icon: 'assets/icons/Calender_icon.png',
                  title: DateFormat("dd/MM/yyyy").format(reciveRequest.time),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomRequestTile extends StatelessWidget {
  final SendRequest sendRequest;

  const CustomRequestTile({
    Key key,
    @required this.sendRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sendRequest.title,
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                IconTitle(
                  icon: 'assets/icons/User_Icon.png',
                  title: sendRequest.userName,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                IconTitle(
                  icon: 'assets/icons/Dollar_icon.png',
                  title: sendRequest.rate.toString(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                IconTitle(
                  icon: 'assets/icons/Location_icon.png',
                  title: sendRequest.location,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                IconTitle(
                  icon: 'assets/icons/Calender_icon.png',
                  title: DateFormat("dd/MM/yyyy").format(sendRequest.time),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IconTitle extends StatelessWidget {
  final String title;
  final String icon;
  const IconTitle({
    this.title,
    this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          child: Image.asset(icon),
        ),
        // Icon(
        //   icon,
        //   size: 10,
        //   color: Colors.white,
        // ),
        SizedBox(
          width: 3,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white38,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
