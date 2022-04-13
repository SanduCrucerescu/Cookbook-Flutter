import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPanelButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const AdminPanelButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        // Spacing between buttons
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: ElevatedButton(
          child: Text(text),
          style: ElevatedButton.styleFrom(
            fixedSize: Size.square(80),
            primary: Colors.black, // NEW
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text("Are you sure you wan't to do this? "),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
