import 'dart:developer';

import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';

class Validator {
  static Future<bool> validate({Map<String, dynamic>? userInfo}) async {
    // var settings = ConnectionSettings(
    //     host: 'localhost',
    //     port: 3306,
    //     user: 'root',
    //     password: 'Crucerescu12?',
    //     db: 'cookbook');
    // var conn = await MySqlConnection.connect(settings);
    // log("message");
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? res = await databaseManager.select(
        table: "members",
        fields: ["*"],
        where: {'email': 'abolandr@gnu.org', 'password': 'xbsxysKe53'});

    // for (var val in res!) {
    //   print(val);
    // }
    print(res);
    // if (res == null) {
    //   log("No result");
    // } else {
    //   for (var rs in res) {
    //     print(rs.toString());
    //     // log(rs);
    //   }
    //   log(dbManager.result.join(", "));
    // }
    return true;
    // if (databaseManager.result == 1) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
