import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Constant/constant.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/helpers/Providers/request_provider.dart';
import 'package:login/screens/contract.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:provider/provider.dart';

import '../customcircularprogressindicator.dart';

class AllRequestWidget extends StatefulWidget {
  @override
  _AllRequestWidgetState createState() => _AllRequestWidgetState();
}

class _AllRequestWidgetState extends State<AllRequestWidget> {
  bool _isLoad = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    setState(() {
      _isLoad = true;
    });
    await Provider.of<RequestProvider>(context, listen: false)
        .loadAllProjectRequests();
    setState(() {
      _isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 30, right: 10),
        child: _isLoad
            ? Center(child: CustomCircularProgressIndicator())
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Send Req
                  sendRequestSide(height),
                  GetConstant.customVerticalDivider(height),
                  // Rec Req
                  recieveRequestSide(height),
                ],
              ),
      ),
    );
  }

  Expanded recieveRequestSide(double height) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetConstant.shared.text(
                text: "RECEVIE REQUEST",
                fontSize: height > divSize ? 22 : 15,
                color: primaryColor,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 5,
            ),
            Consumer<RequestProvider>(
              builder: (context, requestObj, ch) => LimitedBox(
                  maxHeight: height / 2,
                  // maxWidth: 650 / 2 - 10,
                  child: requestObj.reciveRequest.length == 0
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width < 600 ? 10 : 40,
                              vertical: width < 600 ? 22 : 40),
                          child:
                              Image.asset('assets/images/Recore_No_Found.png'),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () => _onTapForRecieveReq(
                                requestObj.reciveRequest[i]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomReciveRequestTile(
                                reciveRequest: requestObj.reciveRequest[i],
                              ),
                            ),
                          ),
                          itemCount: requestObj.reciveRequest.length,
                        )),
            ),
          ],
        ),
      ),
    );
  }

  Expanded sendRequestSide(double height) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetConstant.shared.text(
                text: "SEND REQUEST",
                fontSize: height > divSize ? 22 : 15,
                color: primaryColor,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 5,
            ),
            Consumer<RequestProvider>(
              builder: (context, requestObj, ch) => LimitedBox(
                  maxHeight: height / 2,
                  // maxWidth: 650 / 2 - 10,
                  child: requestObj.sendRequest.length == 0
                      ? Container(
                          padding: EdgeInsets.all(width < 600 ? 0 : 40),
                          child:
                              Image.asset('assets/images/Recore_No_Found.png'),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () =>
                                _onTapForSendReq(requestObj.sendRequest[i]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomRequestTile(
                                sendRequest: requestObj.sendRequest[i],
                              ),
                            ),
                          ),
                          itemCount: requestObj.sendRequest.length,
                        )),
            ),
          ],
        ),
      ),
    );
  }

  _onTapForSendReq(Byme byMeObj) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ProjectDetails(
              byMeObj: byMeObj,
            )));
    //     .then((value) async {
    //   await Provider.of<
    //               RequestProvider>(
    //           context,
    //           listen: false)
    //       .loadAllProjectRequests();
    // });
    print("object");
  }

  _onTapForRecieveReq(Receiverequest requestObj) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Contract(
              byThemPrjObj: requestObj,
            )));
  }
}

class CustomReciveRequestTile extends StatelessWidget {
  final Receiverequest reciveRequest;

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
          GetConstant.shared
              .text(text: reciveRequest.name, fontWeight: FontWeight.bold),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                IconTitle(
                  icon: 'assets/icons/Location_icon.png',
                  title: reciveRequest.where,
                ),
                GetConstant.customContainerForDivideValueInList(),
                IconTitle(
                  icon: 'assets/icons/Calender_icon.png',
                  title: DateFormat("dd/MM/yyyy")
                      .format(DateTime.parse(reciveRequest.startDate)),
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
  final Byme sendRequest;

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
          GetConstant.shared
              .text(text: sendRequest.name, fontWeight: FontWeight.w500),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                IconTitle(
                  icon: 'assets/icons/User_Icon.png',
                  title: sendRequest.what,
                ),
                GetConstant.customContainerForDivideValueInList(),
                IconTitle(
                  icon: 'assets/icons/Dollar_icon.png',
                  title: sendRequest.price.toString(),
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
                  title: sendRequest.where,
                ),
                GetConstant.customContainerForDivideValueInList(),
                IconTitle(
                  icon: 'assets/icons/Calender_icon.png',
                  title: DateFormat("dd/MM/yyyy")
                      .format(DateTime.parse(sendRequest.startDate)),
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
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          child: Image.asset(icon),
        ),
        SizedBox(
          width: 3,
        ),
        GetConstant.shared.text(
            text: title,
            color: Colors.white38,
            fontSize: width < 600 ? 10 : 15),
      ],
    );
  }
}
