import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class EndContract extends StatefulWidget {
  static const routeName = '/endContract';
  final ByThem byThemProjectObj;

  EndContract({this.byThemProjectObj});
  @override
  _EndContractState createState() => _EndContractState();
}

class _EndContractState extends State<EndContract> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: size.height > Constant.divSize ? 40 : 30,
                child: Image.asset('assets/icons/loginbubble.png')),
          ),
          SizedBox(
            width: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProjectDetails.routeName);
            },
            child: Container(
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: size.height > Constant.divSize ? 40 : 30,
                  child: Image.asset('assets/icons/loginbubble.png')),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PageTitle(
                    size: size,
                    title: 'End Contract',
                  ),
                  Padding(
                    padding: size.height > Constant.divSize
                        ? const EdgeInsets.all(28.0)
                        : const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Project Detail",
                          style: TextStyle(
                            color: Constant.primaryColor,
                            fontSize: size.height > Constant.divSize ? 30 : 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 10,
                        ),
                        Text(
                          widget.byThemProjectObj.notes,
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize:
                                  size.height > Constant.divSize ? 25 : 15,
                              letterSpacing: 1.2),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Responsibility",
                          style: TextStyle(
                            color: Constant.primaryColor,
                            fontSize: size.height > Constant.divSize ? 30 : 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 10,
                        ),
                        Responsibility(
                          size: size,
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 5,
                        ),
                        Responsibility(
                          size: size,
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 5,
                        ),
                        Responsibility(
                          size: size,
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 5,
                        ),
                        Responsibility(
                          size: size,
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: size.height > Constant.divSize
                                              ? 40
                                              : 30,
                                          child: Image.asset(
                                              'assets/icons/loginbubble.png')),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "\$ 550.00",
                                      style: TextStyle(
                                        color: Constant.primaryColor,
                                        fontSize: size.height > Constant.divSize
                                            ? 30
                                            : 18,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: size.height > Constant.divSize
                                              ? 40
                                              : 30,
                                          child: Image.asset(
                                              'assets/icons/loginbubble.png')),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      DateFormat("dd-MMM-yyyy")
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                        color: Constant.primaryColor,
                                        fontSize: size.height > Constant.divSize
                                            ? 30
                                            : 18,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Responsibility extends StatelessWidget {
  const Responsibility({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.adjust,
          size: size.height > Constant.divSize ? 25 : 15,
          color: Colors.white54,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "Lorem ipsum is a placeholder demonstrate the visual",
          style: TextStyle(
            color: Colors.white54,
            fontSize: size.height > Constant.divSize ? 25 : 15,
          ),
        ),
      ],
    );
  }
}
