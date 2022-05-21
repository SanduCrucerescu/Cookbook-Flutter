import 'package:flutter/material.dart';

const progressIndicator = Center(
  child: SizedBox(
    height: 100,
    width: 100,
    child: RefreshProgressIndicator(
      color: Colors.black,
      backgroundColor: Colors.white,
    ),
  ),
);
