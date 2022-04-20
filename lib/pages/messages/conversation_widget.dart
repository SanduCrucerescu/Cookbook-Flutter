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

    if (idx % 2 == 0) {
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
    } else {
      return Container(
        height: 100,
        width: size.width / 4,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(100)),
              child: Text("Message"),
            ),
            Text("3:45")
          ],
        ),
      );
    }
  }
}
