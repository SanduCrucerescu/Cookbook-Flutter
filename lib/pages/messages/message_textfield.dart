import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/db/queries/get_messages.dart';
import 'package:cookbook/db/queries/send_message.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/post/directMessage/direct_message.dart';
import 'package:flutter/material.dart';

import 'message_screen.dart';

class MessageTextField extends StatefulWidget {
  final MessagePageController state;
  final TextEditingController messageTec;
  const MessageTextField(
      {Key? key, required this.state, required this.messageTec})
      : super(key: key);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  String? msg;

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          height: 60,
          width: (size.width - 200) / 2,
          child: TextField(
            controller: widget.messageTec,
            onChanged: (value) {
              msg = value;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              hintText: 'Enter message',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  if (msg != null) {
                    await SendMessage.sendMessage(data: {
                      'sender':
                          InheritedLoginProvider.of(context).userData?['email'],
                      'receiver':
                          state.displayedMembers[widget.state.idx].email,
                      'content': msg,
                      'time': DateTime.now().toString()
                    }, n: false);
                    widget.messageTec.clear();
                    msg = '';
                    state.messages = await getMessages(context);
                    state.members = await getMembers(context);
                    state.displayedMessages.clear();
                    for (DirectMessage message in state.messages) {
                      if (message.sender ==
                              state.displayedMembers[state.idx].email ||
                          message.receiver ==
                              state.displayedMembers[state.idx].email) {
                        state.addDisplayedMessage(message);
                      }
                    }
                    state.advancedSetDisplayedMembers(state.members, context);
                    setState(() {});
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
