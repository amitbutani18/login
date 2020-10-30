import 'package:flutter/material.dart';
import 'package:login/screens/projectDetails.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:login/widgets/task.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class Contract extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PageTitle(size: size, title: "Contract"),
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
                          height: size.height > Constant.divSize ? 25 : 10,
                        ),
                        Text(
                          "Amount",
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
                          "\$ 500.00 / Hour",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: size.height > Constant.divSize ? 25 : 15,
                          ),
                        ),
                        SizedBox(
                          height: size.height > Constant.divSize ? 15 : 10,
                        ),
                        Text(
                          "Duration",
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
                          "20 - Jul - 2020  | 30 - Jul -2020",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: size.height > Constant.divSize ? 25 : 15,
                          ),
                        ),
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
