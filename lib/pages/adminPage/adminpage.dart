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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,40,0),
            child: Container(alignment: Alignment.topRight,
              child: CircleAvatar(
                child: Image.asset('assets/images/ph.png'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
            child: TextField(
              showCursor: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter username',
              ),
            ),
          ),
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
                  child: Rectangle(
                      text: "Current User", position: Alignment.topLeft),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: 600,
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
              ],
            ),
          )
        ],
      ),
    ));
  }
}
