import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:typed_data';

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

  test('testing json to blob conversion', () async {
    final file = File('assets/images/imagejson.json');
    final String str = file.readAsStringSync();
    final data = json.decode(str);

    final DatabaseManager dbm = await DatabaseManager.init();

    Future? res = dbm.insert(table: "members", fields: [
      "email",
      "password",
      "username",
      "profile_picture"
    ], data: {
      "email": "Jeff",
      "password": "Amazon",
      "username": "JeffBezos",
      "profile_picture": 
    });
  });
}
