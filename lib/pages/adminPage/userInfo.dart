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
                height: 40,
                width: xSize,
                alignment: Alignment.topCenter,
                child: Text(
                  "Current User:${state.idx}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                child: Container(
                  color: Color.fromARGB(255, 245, 245, 220),
                  alignment: Alignment.topLeft,
                  child: Text(
                      "Name: ${state.userName}\nEmail: ${state.email}\nImage: ${state.image}"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
