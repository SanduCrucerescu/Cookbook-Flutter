import 'package:cookbook/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Rectangle.dart';
import 'AdminPanelButton.dart';

class Admin extends StatefulWidget {
  static const String id = "/admin";

  const Admin({Key? key}) : super(key: key);
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: In Login Screen make Username: Admin return this page
    return (Scaffold(
      backgroundColor: Color(0xFFE3DBCA),
      body: Stack(
        children: [
          NavBar(),
          SideBar(items: sideBarItems),
          Padding(
            padding: const EdgeInsets.fromLTRB(200, 50, 0, 0),
            child: Row(
              children: [
                Expanded(
                    child: Rectangle(
                        text: "User List", position: Alignment.topLeft)),
                Expanded(
                    child: UserInfo(
                        text: "Current User", position: Alignment.topRight))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
