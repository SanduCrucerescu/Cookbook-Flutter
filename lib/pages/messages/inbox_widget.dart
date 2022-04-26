import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/member/member.dart';
import 'message_screen.dart';

class InboxWidget extends StatelessWidget {
  final int idx;
  final MessagePageController state;

  const InboxWidget({
    required this.state,
    required this.idx,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool toggle = false;
    Member member = state.members[idx];

    return Container(
      height: 100,
      width: size.width / 4,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          toggle = !toggle;
          print(toggle);
        },
        child: ListTile(
          leading: ClipOval(
            child: member.profilePicture == null
                ? Image.asset("assets/images/ph.png")
                : Image.memory(member.profilePicture!.toBytes() as Uint8List),
          ),
          title: Text("$idx"),
          subtitle: Text(member.name),
          trailing: SizedBox(
            height: 30,
            width: 30,
            child: TextButton(
              onPressed: () {
                state.removeMember(idx);
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Text("X"),
            ),
          ),
        ),
      ),
    );
  }
}
