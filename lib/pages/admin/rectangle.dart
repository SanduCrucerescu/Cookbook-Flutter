import 'package:cookbook/components/refresh_progress_indicator.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/admin/admin_page.dart';
import 'package:cookbook/pages/admin/search_add.dart';
import 'package:cookbook/pages/admin/user_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rectangle extends StatelessWidget {
  final String text;
  final SelectedUserChangeNotifier state;

  const Rectangle({
    required this.text,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width / 2,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SearchAdd(state: state),
            UsersColumn(state: state),
          ],
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      members = await getMembers(
          context, InheritedLoginProvider.of(context).member!.email);
      displayedmembers = members;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    displayedmembers = [];
    final Size size = MediaQuery.of(context).size;

    for (Member member in members) {
      if (member.email.startsWith(widget.state.filteringString)) {
        displayedmembers.add(member);
      }
    }

    if (members.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: progressIndicator,
      );
    } else {
      return Container(
        height: size.height - 210,
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: displayedmembers.length,
          itemBuilder: (BuildContext context, int idx) {
            return UserTile(
              state: widget.state,
              idx: idx,
              email: displayedmembers[idx].email,
              userName: displayedmembers[idx].name,
              profilePic: displayedmembers[idx].profilePicture,
              member: displayedmembers[idx],
            );
          },
        ),
      );
    }
  }
}
