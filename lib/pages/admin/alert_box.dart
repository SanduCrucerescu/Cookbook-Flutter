import 'package:cookbook/pages/register/register.dart';
import 'package:flutter/material.dart';

Future<dynamic> addMemberFromAdmin(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(actions: [
      RegisterForm(
        showShadow: false,
      )
    ]),
  );
}
