import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/helpers/Providers/membersprovider.dart';
import 'package:login/screens/allcontract.dart';
import 'package:login/screens/searchmember.dart';
import 'package:login/widgets/pagebackground.dart';
import 'package:login/widgets/Page_titles/pagetitle.dart';
import 'package:provider/provider.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class ProjectADetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MembersProvider>(context).items;

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
              Navigator.of(context).pushNamed(AllContract.routeName);
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
                  PageTitle(size: size, title: 'Details'),
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
                          "Detail",
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Location",
                                    style: TextStyle(
                                      color: Constant.primaryColor,
                                      fontSize: size.height > Constant.divSize
                                          ? 30
                                          : 20,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height > Constant.divSize
                                        ? 15
                                        : 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        size: size.height > Constant.divSize
                                            ? 25
                                            : 15,
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
                                              size.height > Constant.divSize
                                                  ? 25
                                                  : 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Duration",
                                    style: TextStyle(
                                      color: Constant.primaryColor,
                                      fontSize: size.height > Constant.divSize
                                          ? 30
                                          : 20,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height > Constant.divSize
                                        ? 15
                                        : 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.calendar_today,
                                        size: size.height > Constant.divSize
                                            ? 25
                                            : 15,
                                        color: Colors.white54,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        DateFormat("dd-MMMM-yyyy")
                                            .format(DateTime.now()),
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 25
                                                  : 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
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
                        // Task(
                        //   size: size,
                        //   task1:
                        //       'Lorem ipsum is a placeholder text commonly used to demonstrate the visual',
                        // ),
                        // SizedBox(
                        //   height: size.height > Constant.divSize ? 10 : 10,
                        // ),
                        // Task(
                        //   size: size,
                        //   task1:
                        //       'Lorem ipsum is a placeholder demonstrate the visual',
                        // ),
                        // SizedBox(
                        //   height: size.height > Constant.divSize ? 10 : 10,
                        // ),
                        // Task(
                        //   size: size,
                        //   task1: 'Commonly used to demonstrate the visual.',
                        // ),
                        // SizedBox(
                        //   height: size.height > Constant.divSize ? 10 : 10,
                        // ),
                        // Task(
                        //   size: size,
                        //   task1: 'Placeholder text commonly used.',
                        // ),
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
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          width: 50,
                          height: 1,
                          color: Constant.primaryColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          width:
                              size.height > Constant.divSize ? size.width : 700,
                          height: size.height > Constant.divSize ? 450 : 150,
                          alignment: Alignment.topLeft,
                          color: Colors.transparent,
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: memberData.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    // maxCrossAxisExtent: 200,
                                    childAspectRatio: 1 / 0.43,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3),
                            itemBuilder: (_, i) => Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        memberData[i].name,
                                        style: TextStyle(
                                          color: Constant.primaryColor,
                                          fontSize:
                                              size.height > Constant.divSize
                                                  ? 35
                                                  : 20,
                                        ),
                                      ),
                                    ),
                                    IconAndName(
                                      size: size,
                                      icon: Icon(
                                        Icons.people,
                                        color: Colors.white54,
                                        size: size.height > Constant.divSize
                                            ? 25
                                            : 15,
                                      ),
                                      name: "memberData[i].secondName",
                                    ),
                                    IconAndName(
                                      size: size,
                                      icon: Icon(
                                        Icons.attach_money,
                                        color: Colors.white54,
                                        size: size.height > Constant.divSize
                                            ? 25
                                            : 15,
                                      ),
                                      name: '\$ ${memberData[i].dailycharge}',
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  height: size.height,
                                  color: Constant.primaryColor,
                                  width: 2,
                                )
                              ],
                            ),
                          ),
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
