import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adminpage.dart';

class UserTile extends StatelessWidget {
  // TODO final Member member;
  final int idx;
  final SelectedUserChangeNotifier state;

  const UserTile({
    // TODO required this.member,
    required this.idx,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        color: idx.isEven
            ? const Color.fromARGB(255, 245, 245, 220)
            : const Color.fromARGB(255, 245, 245, 220),
        child: Padding(
          // Size of the user boxes (icon and name)
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              log("${state.idx}");
              state.idx = idx;
              log("${state.idx}");
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('$idx'),
                  );
                },
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: CircleAvatar(
                    child: Image.asset('assets/images/ph.png'),
                  ),
                ),
                const Text(
                  "Username",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
