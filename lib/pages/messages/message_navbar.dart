import 'package:cookbook/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageNavBar extends StatelessWidget {
  const MessageNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 100,
      width: size.width,
      color: kcMedBeige,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset('assets/images/temp_logo.png'),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {},
              child: Text("Click"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(left: 300), child: Text("Rick James")),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    child: Image.asset('assets/images/ph.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
