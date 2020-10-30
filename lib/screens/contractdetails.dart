import 'package:flutter/material.dart';
import 'package:login/screens/contract.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class ContractDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GradientButton(
            color1: Colors.green,
            color2: Colors.greenAccent,
            iconData: Icons.check,
            size: size,
          ),
          SizedBox(
            width: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Contract(),
              ));
            },
            child: GradientButton(
              color1: Colors.red,
              color2: Colors.redAccent,
              iconData: Icons.close,
              size: size,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PageBackground(size: size, imagePath: 'assets/background.png'),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PageTitle(size: size, title: "Contract Detils"),
                  SizedBox(
                    height: size.height > Constant.divSize ? 20 : 8,
                  ),
                  Padding(
                    padding: size.height > Constant.divSize
                        ? const EdgeInsets.all(28.0)
                        : const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Project",
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
                          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual.",
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize:
                                  size.height > Constant.divSize ? 25 : 15,
                              letterSpacing: 1.2),
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 25 : 10,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(
                            color: Constant.primaryColor,
                            fontSize: size.height > Constant.divSize ? 30 : 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: size.height > Constant.divSize ? 25 : 15,
                              color: Colors.white54,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "London , Europ",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize:
                                    size.height > Constant.divSize ? 25 : 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 25 : 10,
                        ),
                        Text(
                          "Team Member",
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
                          "Akash Gajera , Kapil Maheshvari , Harshad Pavasiya , Rahul Dabhi",
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize:
                                  size.height > Constant.divSize ? 25 : 15,
                              letterSpacing: 1.2),
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 25 : 10,
                        ),
                        Text(
                          "Task",
                          style: TextStyle(
                            color: Constant.primaryColor,
                            fontSize: size.height > Constant.divSize ? 30 : 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 10,
                        ),
                        Task(
                          size: size,
                          task1:
                              'Lorem ipsum is a placeholder text commonly used to demonstrate the visual',
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 10 : 10,
                        ),
                        Task(
                          size: size,
                          task1:
                              'Lorem ipsum is a placeholder demonstrate the visual',
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 10 : 10,
                        ),
                        Task(
                          size: size,
                          task1: 'Commonly used to demonstrate the visual.',
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 10 : 10,
                        ),
                        Task(
                          size: size,
                          task1: 'Placeholder text commonly used.',
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    GradientButton(
                                      color1: Constant.primaryColor,
                                      color2: Constant.primaryColor,
                                      iconData: Icons.attach_money,
                                      size: size,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: size.height > Constant.divSize
                                            ? 30
                                            : 15,
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
                                    GradientButton(
                                      color1: Constant.primaryColor,
                                      color2: Constant.primaryColor,
                                      iconData: Icons.timer,
                                      size: size,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: size.height > Constant.divSize
                                            ? 30
                                            : 15,
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
          ),
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key key,
    @required this.color1,
    @required this.color2,
    @required this.iconData,
    @required this.size,
  }) : super(key: key);
  final IconData iconData;
  final Color color1;
  final Color color2;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [
            color1,
            color2,
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: size.height > Constant.divSize ? 40 : 20,
          child: Icon(
            iconData,
            color: Colors.black,
            size: size.height > Constant.divSize ? 40 : 20,
          ),
        ));
  }
}

class Task extends StatelessWidget {
  const Task({
    Key key,
    @required this.size,
    @required this.task1,
  }) : super(key: key);

  final Size size;

  final String task1;

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
          task1,
          style: TextStyle(
            color: Colors.white54,
            fontSize: size.height > Constant.divSize ? 25 : 15,
          ),
        ),
      ],
    );
  }
}
