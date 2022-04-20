import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationWidget extends StatelessWidget {
  final int idx;

  const ConversationWidget({
    required this.idx,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 100,
      width: size.width / 4,
      child: ListTile(
        leading: CircleAvatar(
          child: Image.asset('assets/images/ph.png'),
        ),
        title: Text("$idx"),
        trailing: Text("3:45"),
      ),
    );
  }
}
