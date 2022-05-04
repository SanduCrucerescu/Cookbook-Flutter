import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/member/member.dart';
import '../../models/post/directMessage/direct_message.dart';
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
    Member member = state.displayedMembers[idx];

    return Container(
      height: 100,
      width: size.width / 4,
      padding: const EdgeInsets.only(top: 15),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          state.toggle = !state.toggle;
          state.idx = idx;
          if (state.toggle == false) {
            state.displayedMessages.clear();
          } else {
            state.displayedMessages = [];
            for (DirectMessage message in state.messages) {
              if (message.sender == state.displayedMembers[state.idx].email ||
                  message.receiver == state.displayedMembers[state.idx].email) {
                state.addDisplayedMessage(message);
              }
            }
          }
        },
        child: ListTile(
          leading: Profile_Pic(member: member),
          title: Text(member.name),
          subtitle: Text(
            last(),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: SizedBox(
            height: 30,
            width: 30,
            child: TextButton(
              onPressed: () {
                state.removeDisplayedMember(member);
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Text("X"),
            ),
          ),
        ),
      ),
    );
  }

  String last() {
    List<DirectMessage> l = [];
    for (DirectMessage message in state.messages) {
      if (message.receiver == state.displayedMembers[idx].email ||
          message.sender == state.displayedMembers[idx].email) {
        l.add(message);
      }
    }
    if (l.isEmpty) {
      return "No messages";
    } else {
      if (l[0].date.toString() != DateTime.now().toString().substring(0, 10)) {
        return l[0].content.toString() +
            " " * 50 +
            l[0].date.toString().substring(0, 10);
      } else {
        return l[0].content.toString() + "" + l[0].time.toString();
      }
    }
  }
}

class Profile_Pic extends StatelessWidget {
  const Profile_Pic({
    Key? key,
    required this.member,
  }) : super(key: key);

  final Member member;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: member.profilePicture == null
          ? Image.asset("assets/images/ph.png")
          : Image.memory(member.profilePicture!.toBytes() as Uint8List),
    );
  }
}
