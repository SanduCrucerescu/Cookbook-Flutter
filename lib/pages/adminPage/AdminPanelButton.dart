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
        child: MaterialButton(
<<<<<<< HEAD
            child: Text(text),
            color: Colors.blue,
            hoverColor: Colors.blue,
            onPressed: onPressed()),
=======
          child: Text(text),
          color: Colors.blue, hoverColor: Colors.blue,

          onPressed: onPressed()
        ),
>>>>>>> origin/flutter
      ),
    );
  }
}
<<<<<<< HEAD
=======

>>>>>>> origin/flutter
