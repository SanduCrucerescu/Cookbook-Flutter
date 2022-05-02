import 'package:cookbook/pages/messages/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    Size size = MediaQuery.of(context).size;

    if (state.displayedMessages[idx].sender != 'abolandr@gnu.org') {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 50, left: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              child: Image.asset('assets/images/ph.png'),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                state.displayedMessages[idx].content,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Text(state.displayedMessages[idx].time),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 50, right: 8),
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
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                state.displayedMessages[idx].content,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            Text(state.displayedMessages[idx].time),
          ],
        ),
      );
    }
  }
}
