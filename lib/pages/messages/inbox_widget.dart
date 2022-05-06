import 'dart:typed_data';

import 'package:cookbook/controllers/loadimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

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
    final _last = last();

    return Container(
      height: 100,
      width: size.width / 4,
      padding: const EdgeInsets.only(top: 15),
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onDoubleTap: () {
          state.toggle = false;
        },
        onTap: () {
          state.toggle = true;
          state.idx = idx;
          state.displayedMessages.clear();
          state.displayedMessages = [];
          for (DirectMessage message in state.messages) {
            if (message.sender == state.displayedMembers[state.idx].email ||
                message.receiver == state.displayedMembers[state.idx].email) {
              state.addDisplayedMessage(message);
            }
          }
        },
        child: ListTile(
          leading: ProfilePic(member: member),
          title: Text(
            member.name,
            style: const TextStyle(fontSize: 14),
          ),
          subtitle: _last == null
              ? const Text('No messages')
              : Text(_last.content.toString(), overflow: TextOverflow.ellipsis),
          trailing:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _last == null
                ? const Text('')
                : Text(
                    _last.date.toString().substring(0, 10),
                  ),
            const SizedBox(
              height: 5,
            ),
            _last == null
                ? const Text('')
                : Text(
                    _last.time.toString(),
                  ),
          ]),
        ),
      ),
    );
  }

  DirectMessage? last() {
    List<DirectMessage> l = [];
    for (DirectMessage message in state.messages) {
      if (message.receiver == state.displayedMembers[idx].email ||
          message.sender == state.displayedMembers[idx].email) {
        l.add(message);
      }
    }
    if (l.isNotEmpty) {
      return l[0];
    }
    return null;
  }
}

class ProfilePic extends StatelessWidget {
  final Member member;
  final double? height, width, scale;

  const ProfilePic({
    Key? key,
    required this.member,
    this.height,
    this.width,
    this.scale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: member.profilePicture == null
          ? Image.asset(
              "assets/images/ph.png",
              height: height,
              width: width,
            )
          : Image.memory(
              getImageDataFromBlob(member.profilePicture!),
              width: width,
              height: height,
              scale: scale ?? 1.0,
              fit: BoxFit.cover,
            ),
    );
  }
}
