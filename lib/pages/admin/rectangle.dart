import 'package:cookbook/db/database_manager.dart';
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
  List<String> userEmails = [];
  List<String> displayedEmails = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      dbManager = await DatabaseManager.init();

      Results? res =
          await dbManager?.select(table: 'members', fields: ['email']);

      for (var r in res!) {
        userEmails.add(r['email'].toString());
        // print(r['email']);
      }
      displayedEmails = userEmails;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    displayedEmails = [];
    print(widget.state.filteringString);

    for (String email in userEmails) {
      if (email.startsWith(widget.state.filteringString)) {
        displayedEmails.add(email);
      }
    }

    if (userEmails.isEmpty) {
      return const CircularProgressIndicator();
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
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
