import 'dart:developer';

import 'package:cookbook/controllers/gettingrecepies.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';

class Validator {
  Future<bool> validate({Map<String, dynamic>? userInfo}) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? res = await databaseManager.exists(table: "members", fields: [
      "*"
    ], where: {
      'email': userInfo?["email"],
      'password': userInfo?["password"]
    });

    //abolandr@gnu.org
    //xbsxysKe53
    int result = 0;
    GetRecepies getrecepies = GetRecepies();
    for (var rs in res!) {
      result = rs[0];
    }
    if (result == 1) {
      await getrecepies.getrecep();
      //print(getrecepies.recepieList);
      return true;
    } else {
      return false;
    }
  }
}
