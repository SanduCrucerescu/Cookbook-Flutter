import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/admin/admin_page.dart';
import 'package:cookbook/pages/admin/search_add.dart';
import 'package:cookbook/pages/admin/user_tile.dart';
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
                SearchAdd(state: state),
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
  List<Member> members = [];
  List<Member> displayedmembers = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      dbManager = await DatabaseManager.init();

      Results? res = await dbManager?.select(table: 'members', fields: ['*']);

      for (var r in res!) {
        final curr = Member(
          name: r['username'],
          email: r['email'],
          password: r['password'],
        );
        members.add(curr); // Something wrong here
      }
      displayedmembers = members;
      widget.state.currMember = displayedmembers[0];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    displayedmembers = [];
    //print(widget.state.filteringString);

    for (Member member in members) {
      if (member.email.startsWith(widget.state.filteringString)) {
        displayedmembers.add(member);
      }
    }

    if (members.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Column(children: const [CircularProgressIndicator()]),
      );
    } else {
      return Container(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Scrollbar(
              isAlwaysShown: true,
              showTrackOnHover: true,
              child: ListView.builder(
                itemCount: displayedmembers.length,
                itemBuilder: (BuildContext context, int idx) {
                  return UserTile(
                    state: widget.state,
                    idx: idx,
                    email: displayedmembers[idx].email,
                    userName: displayedmembers[idx].name,
                  );
                },
              ),
            ),
          ),
        ),
      );
    }
  }
}
