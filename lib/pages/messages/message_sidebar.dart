import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageSidebar extends StatelessWidget {
  const MessageSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - 100,
      width: 200,
      color: Colors.red,
      child: Column(),
    );
  }
}
