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
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
          //   child: CircleAvatar(
          //     child: Image.asset('assets/images/ph.png'),
          //   ),
          //),
          const Padding(
              padding: EdgeInsets.fromLTRB(100, 0, 100, 0), child: NavBar1()),
          // Boxes
          SizedBox(
            height: size.height - 100,
            child: Row(
              children: [
                const Expanded(
                  child: Rectangle(
                      text: "User List", position: Alignment.topRight),
                ),
                const Expanded(
                  child: UserInfo(
                      text: "Current User", position: Alignment.topLeft),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 600,
                      child: Container(
                        child: Column(
                          children: [
                            AdminPanelButton(
                              text: "Add",
                              onPressed: () {},
                            ),
                            AdminPanelButton(
                              text: "Delete",
                              onPressed: () {},
                            ),
                            AdminPanelButton(
                              text: "Edit",
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
