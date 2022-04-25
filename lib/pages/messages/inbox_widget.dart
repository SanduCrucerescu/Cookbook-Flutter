import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_screen.dart';

class InboxWidget extends StatelessWidget {
  final int idx;
  final MessagesChangeNotifier state;

  const InboxWidget({
    required this.state,
    required this.idx,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool toggle = false;

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
          leading: CircleAvatar(
            child: Image.asset('assets/images/ph.png'),
          ),
          title: Text("$idx"),
          subtitle: const Text("Some message"),
          trailing: SizedBox(
            height: 30,
            width: 30,
            child: TextButton(
              onPressed: () {
                state.removeMessage(idx);
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
