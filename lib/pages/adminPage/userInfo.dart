import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adminpage.dart';

class UserInfo extends StatelessWidget {
  final String text;
  final position;
  final SelectedUserChangeNotifier state;

  const UserInfo({
    required this.text,
    required this.position,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double xSize = 600;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          height: 850,
          width: 600,
          //Title of the rectangle
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                height: 40,
                width: xSize,
                alignment: Alignment.topCenter,
                child: Text(
                  "${state.idx}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                    "Name: ${state.userName}\nEmail: ${state.email}\nImage: ${state.image}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
