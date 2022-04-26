import 'package:cookbook/theme/colors.dart';
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
        decoration: BoxDecoration(
            color: kcLightBeige,
            border: Border.all(
              color: kcMedGrey,
              width: .5,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(5)),
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
                  padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
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
