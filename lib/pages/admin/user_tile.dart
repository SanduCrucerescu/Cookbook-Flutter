import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/messages/inbox_widget.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/src/blob.dart';

import 'admin_page.dart';

class UserTile extends StatelessWidget {
  final Member member;
  final int idx;
  final SelectedUserChangeNotifier state;
  final String email;
  final String userName;
  final Blob? profile_pic;

  const UserTile({
    required this.member,
    required this.email,
    required this.idx,
    required this.state,
    required this.userName,
    required this.profile_pic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
<<<<<<< HEAD
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
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              state.email = email;
              state.userName = userName;
              state.currMember = member;
            },
            child: ListTile(
              leading: Profile_Pic(member: member),
              title: Text(
                member.email,
              ),
              subtitle: Text(member.name),
=======
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
          child: ListTile(
            leading: Profile_Pic(member: member),
            title: Text(
              email,
>>>>>>> d9b0b6b7b3f63dc81ff536953836412d3c6dae02
            ),
          ),
        ),
      ),
    );
  }
}
