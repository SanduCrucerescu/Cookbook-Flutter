import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';

class AddUser {
  static Future<bool> adding({Map<String, dynamic>? userInfo}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();

    Future? res = dbManager.insert(table: "members", fields: [
      "email",
      "password",
      "username",
      "profile_pic"
    ], data: {
      "email": userInfo?["email"],
      "password": userInfo?["password"],
      "username": userInfo?["username"],
      "profile_picture": userInfo?["profile_pic"]
    });
    dbManager.close();
    return true;
  }
}
