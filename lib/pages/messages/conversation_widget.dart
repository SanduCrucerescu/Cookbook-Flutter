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
        padding: EdgeInsets.only(bottom: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8),
              child: CircleAvatar(
                child: Image.asset('assets/images/ph.png'),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.lightGreenAccent[400],
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Message jjdkjd kjdkhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Container(child: Text("12:45"))
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.lightBlue[500],
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Messagssssssssssssssssssssssssssssssssssssssssssssssssssssssssssse",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: Text("3:45"),
            ),
          ],
        ),
      );
    }
  }
}
