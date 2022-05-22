import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/db/queries/get_messages.dart';
import 'package:cookbook/db/queries/send_message.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/post/directMessage/direct_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'message_screen.dart';

class MessageTextField extends StatefulHookConsumerWidget {
  final EdgeInsets? padding, margin;
  final Function? onSubmitted;
  final TextEditingController controller;
  final double? height, width;

  const MessageTextField({
    required this.controller,
    this.onSubmitted,
    this.padding,
    this.margin,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends ConsumerState<MessageTextField> {
  String? msg;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(membersProvider);

    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: widget.height ?? 60,
          width: widget.width ?? size.width - 200,
          // margin: widget.margin,
          padding: widget.padding,
          child: TextField(
            onSubmitted: (msg) async {
              widget.onSubmitted;
              // if (msg != '') {
              //   await SendMessage.sendMessage(data: {
              //     'sender':
              //         InheritedLoginProvider.of(context).userData?['email'],
              //     'receiver': state.displayedMembers[state.idx].email,
              //     'content': msg,
              //     'time': DateTime.now().toString()
              //   }, n: false);
              //   widget.controller.clear();
              //   msg = '';
              //   state.messages = await getMessages(context);
              //   state.members = await getMembers(context);
              //   state.displayedMessages.clear();
              //   for (DirectMessage message in state.messages) {
              //     if (message.sender ==
              //             state.displayedMembers[state.idx].email ||
              //         message.receiver ==
              //             state.displayedMembers[state.idx].email) {
              //       state.addDisplayedMessage(message);
              //     }
              //   }
              //   state.advancedSetDisplayedMembers(state.members, context);
              //   setState(() {});
              // }
            },
            controller: widget.controller,
            onChanged: (value) {
              print(widget.controller.text);
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
                  await widget.onSubmitted;
                },
                // onPressed: widget.onSubmitted ??
                //     () async {
                //       if (msg != null && msg != '') {
                //         await SendMessage.sendMessage(data: {
                //           'sender': InheritedLoginProvider.of(context)
                //               .userData?['email'],
                //           'receiver': state.displayedMembers[state.idx].email,
                //           'content': msg,
                //           'time': DateTime.now().toString()
                //         }, n: false);
                //         widget.controller.clear();
                //         msg = '';
                //         state.messages = await getMessages(context);
                //         state.members = await getMembers(context);
                //         state.displayedMessages.clear();
                //         for (DirectMessage message in state.messages) {
                //           if (message.sender ==
                //                   state.displayedMembers[state.idx].email ||
                //               message.receiver ==
                //                   state.displayedMembers[state.idx].email) {
                //             state.addDisplayedMessage(message);
                //           }
                //         }
                //         state.advancedSetDisplayedMembers(
                //             state.members, context);
                //         setState(() {});
                //       }
                // },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
