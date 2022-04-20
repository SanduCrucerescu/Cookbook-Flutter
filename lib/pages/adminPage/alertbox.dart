import 'package:cookbook/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> addMemberFromAdmin(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Add new member'),
      content: Expanded(
        child: SizedBox(
          height: 250,
          width: 400,
          child: Column(children: [
            CustomTextField(
              hintText: "Full Name",
            ),
            CustomTextField(hintText: "Email"),
            CustomTextField(hintText: "Password"),
          ]),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
