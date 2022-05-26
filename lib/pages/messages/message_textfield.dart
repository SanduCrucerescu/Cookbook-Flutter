// ignore_for_file: use_build_context_synchronously

import 'package:cookbook/db/queries/get_comments.dart';
import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/db/queries/get_messages.dart';
import 'package:cookbook/db/queries/send_message.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/directMessage/direct_message.dart';
import 'package:cookbook/pages/comments/comments.dart';
import 'package:cookbook/pages/comments/comments_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'message_screen.dart';

class MessageTextField extends StatefulHookConsumerWidget {
  final EdgeInsets? padding, margin;
  final TextEditingController controller;
  final double? height, width;
  final bool regularMessage;
  final CommentsPageController? commentsPageState;

  const MessageTextField({
    required this.controller,
    required this.regularMessage,
    this.commentsPageState,
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
  String msg = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> send({
    required MessagePageController state,
    required String email,
    required String message,
  }) async {
    if (widget.regularMessage) {
      if (message != '') {
        await SendMessage.sendMessage(data: {
          'sender': email,
          'receiver': state.displayedMembers[state.idx].email,
          'content': message,
          'time': DateTime.now().toString()
        }, isLink: false);
        state.messages = await getMessages(context);
        state.members = await getMembers(
          context,
          // email,
        );
        state.displayedMessages.clear();
        for (DirectMessage message in state.messages) {
          if (message.sender == state.displayedMembers[state.idx].email ||
              message.receiver == state.displayedMembers[state.idx].email) {
            state.addDisplayedMessage(message);
          }
        }
      }
      state.advancedSetDisplayedMembers(state.members, context);
    } else {
      if (widget.commentsPageState == null) {
        return;
      }
      widget.controller.clear();
      final Member member = await getMember(email);
      await sendComment(
        postId: widget.commentsPageState!.id,
        member: member,
        content: message,
        isPostComment: widget.commentsPageState!.isPostComment ? 1 : 0,
      );
      ref.watch(commentsProvider).comments =
          await getComments(id: widget.commentsPageState!.id);
      setState(() {});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(membersProvider);
    final loginProvider = InheritedLoginProvider.of(context);

    return Row(
      children: [
        Container(
          height: widget.height ?? 60,
          width: widget.width ?? size.width - 200,
          // margin: widget.margin,
          padding: widget.padding,
          child: TextField(
            controller: widget.controller,
            onChanged: (val) {
              msg = val;
            },
            onSubmitted: (msg) async {
              await send(
                message: msg,
                state: state,
                email: loginProvider.member!.email,
              );
              widget.controller.clear();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: .5),
              ),
              hintText: 'Enter message',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  await send(
                    message: msg,
                    state: state,
                    email: loginProvider.member!.email,
                  );

                  widget.controller.clear();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
