import 'package:cookbook/main.dart';
import 'package:cookbook/pages/messages/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'inbox_widget.dart';

class ConversationWidget extends StatelessWidget {
  final int idx;
  final MessagePageController state;

  const ConversationWidget({
    required this.idx,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.displayedMessages[idx].receiver ==
        (InheritedLoginProvider.of(context).userData?['email'])) {
      return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(state.displayedMessages[idx].date?.substring(0, 10) ?? ''),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 50, left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    maxRadius: 25,
                    child: ProfilePic(
                      member: state.displayedMembers[state.idx],
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      state.displayedMessages[idx].content ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(state.displayedMessages[idx].time ?? ''),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(state.displayedMessages[idx].date?.substring(0, 10) ?? ''),
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 50, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[500],
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      state.displayedMessages[idx].content ?? '',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(state.displayedMessages[idx].time ?? ''),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  bool check(int idx) {
    for (int i = 0; i < state.displayedMessages.length - 1; i++) {
      if (idx == 0) {
        return true;
      } else if (state.displayedMessages[idx].date
              .toString()
              .substring(0, 10) ==
          state.displayedMessages[idx + 1].date.toString().substring(0, 10)) {
        return false;
      }
    }
    return true;
  }
}
