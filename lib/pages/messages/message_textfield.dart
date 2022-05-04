import 'package:cookbook/controllers/send_message.dart';
import 'package:cookbook/main.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          height: 60,
          width: (size.width - 200) / 2,
          child: TextField(
            controller: widget.messageTec,
            onChanged: (value) {
              widget.state.message = value;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              hintText: 'Enter message',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (widget.state.message.isNotEmpty) {
                    SendMessage.sendMessage(data: {
                      'sender':
                          InheritedLoginProvider.of(context).userData?['email'],
                      'receiver':
                          widget.state.displayedMembers[widget.state.idx].email,
                      'content': widget.state.message,
                      'time': DateTime.now().toString()
                    });
                    widget.messageTec.clear();
                    widget.state.message = '';
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
