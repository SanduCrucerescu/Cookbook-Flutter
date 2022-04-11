// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:developer';

import 'package:cookbook/db/database_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cookbook/main.dart';
import 'package:mysql1/mysql1.dart';

void main() {
  test('testing connection to database', () async {
    final DatabaseManager dbManager = await DatabaseManager.init();
    // final DatabaseManager dbManager = DatabaseManager();

    // dbManager.connect();

    Results? res = await dbManager.select(
      table: 'recipes',
      fields: ['*'],
    );

    if (res == null) {
      log("No result");
    } else {
      for (var rs in res) {
        print(rs.toString());
        // log(rs);
      }
      log(dbManager.result.join(", "));
    }
  });
}
