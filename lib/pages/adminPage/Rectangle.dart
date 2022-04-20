import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/adminPage/adminpage.dart';
import 'package:cookbook/pages/adminPage/searchAdd.dart';
import 'package:cookbook/pages/adminPage/userTile.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class Rectangle extends StatelessWidget {
  final String text;
  final SelectedUserChangeNotifier state;
  final position;

  const Rectangle({
    required this.text,
    required this.state,
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double xSize = 600;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          // Height and width of the boxes
          height: 850,
          width: 600,
          //Title of the rectangle
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                searchadd(state: state),
                UsersColumn(state: state),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UsersColumn extends StatefulWidget {
  const UsersColumn({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SelectedUserChangeNotifier state;

  @override
  State<UsersColumn> createState() => _UsersColumnState();
}

class _UsersColumnState extends State<UsersColumn> {
  DatabaseManager? dbManager;
  //List<Member> members = [];
  //List<String> displayedmembers = [];
  List<String> displayedEmails = [];
  List<String> userEmails = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      dbManager = await DatabaseManager.init();

      Results? res =
          await dbManager?.select(table: 'members', fields: ['email']);

      for (var r in res!) {
        userEmails.add(r['email']);
        // print(r['email']);
      }
      displayedEmails = userEmails;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    displayedEmails = [];
    //print(widget.state.filteringString);

    for (String email in userEmails) {
      if (email.startsWith(widget.state.filteringString)) {
        displayedEmails.add(email);
      }
    }

    if (userEmails.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Column(children: [const CircularProgressIndicator()]),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Scrollbar(
            isAlwaysShown: true,
            showTrackOnHover: true,
            child: ListView.builder(
              itemCount: displayedEmails.length,
              itemBuilder: (BuildContext context, int idx) {
                return UserTile(
                  state: widget.state,
                  idx: idx,
                  email: displayedEmails[idx],
                  userName: "TODO Create a query for usernames",
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
