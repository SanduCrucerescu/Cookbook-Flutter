<<<<<<< HEAD
import 'dart:developer';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:flutter/cupertino.dart';
=======
import 'package:cookbook/theme/colors.dart';
>>>>>>> 5206413 (smol fixes v.2)
import 'package:flutter/material.dart';
import 'admin_page.dart';

class UserTile extends StatelessWidget {
  // TODO final Member member;
  final int idx;
  final SelectedUserChangeNotifier state;
  // final Member member;
  final String email;
  final String userName;

  const UserTile({
    // TODO required this.member,
    required this.email,
    required this.idx,
    // required this.member,
    required this.state,
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
<<<<<<< HEAD
<<<<<<< HEAD
        color: idx.isEven
            ? const Color.fromARGB(255, 245, 245, 220)
            : const Color.fromARGB(255, 245, 245, 220),
=======
        color: idx.isEven ? kcMedBeige : kcLightBeige,
>>>>>>> ecde988 (changed size of user info)
=======
        color: idx.isEven ? kcMedBeige : kcLightBeige, // <---- Colors here
>>>>>>> 5206413 (smol fixes v.2)
        child: Padding(
          // Size of the user boxes (icon and name)
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              state.email = email;
              state.userName = userName;
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: CircleAvatar(
                    child: state.image,
                  ),
                ),
                Text(
                  email,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
