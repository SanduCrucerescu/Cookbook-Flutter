import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';

class AddUser {
  static Future<bool> adding({Map<String, dynamic>? userInfo}) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Future? res = databaseManager.insert(table: "members", fields: [
      "email",
      "password",
      "username",
      "profile_picture"
    ], data: {
      "email": userInfo?["email"],
      "password": userInfo?["password"],
      "username": userInfo?["username"],
      "profile_picture": userInfo?["profile_picture"]
    });
    return true;
  }
}
