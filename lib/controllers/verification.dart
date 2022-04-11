import 'dart:developer';

import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';

class Validator {
  static Future<bool> validate({Map<String, dynamic>? userInfo}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();

    // Results? res = await databaseManager.select(
    //     table: "members",
    //     fields: ["*"],
    //     where: {'email': userInfo!["email"], 'password': userInfo["password"]});

    // for (var val in res!) {
    //   print(val);
    // }

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
    return true;
    // if (databaseManager.result == 1) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
