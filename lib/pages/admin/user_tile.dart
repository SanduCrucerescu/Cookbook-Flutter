import 'package:cookbook/controllers/get_image_from_blob.dart';
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
  final Blob? profilePic;
  final Color? color;

  const UserTile({
    required this.member,
    required this.email,
    required this.idx,
    required this.state,
    required this.userName,
    required this.profilePic,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: color ?? kcLightBeige,
        border: Border.all(
          color: kcMedGrey,
          width: .5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          state.email = email;
          state.userName = userName;
          state.currMember = member;
        },
        onHover: (val) {},
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  height: 70,
                  width: 80,
                  child: ClipOval(
                    child: ProfilePic(
                      padding: const EdgeInsets.all(0),
                      member: member,
                      scale: .5,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(member.email),
                      Text(member.name),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
