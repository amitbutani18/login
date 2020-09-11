import 'package:flutter/material.dart';
import 'package:login/API/logout.dart';
import 'package:provider/provider.dart';

class DashbordDrawer extends StatelessWidget {
  const DashbordDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            Navigator.of(context).pushNamed('/own-profile');
          },
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 15,
              child: Image.asset('assets/icons/profileIcon.png'),
            ),
          ),
        ),
        IconButton(
          color: Colors.amber,
          icon: Icon(Icons.settings),
          onPressed: () async {
            Navigator.of(context).pushNamed('/settings');
          },
        ),
        GestureDetector(
          onTap: () async {
            await Provider.of<LogOut>(context, listen: false).logOut();
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 15,
              child: Image.asset('assets/icons/logout.png'),
            ),
          ),
        ),
      ],
    ));
  }
}
