import 'dart:ffi';

import 'package:cookbook/db/database_manager.dart';

class AddWeaklys {
  static Future<bool> addWeaklys({Map<String, dynamic>? data}) async {
    DatabaseManager databaseManager = await DatabaseManager.init();

    Future? insert = databaseManager.insert(table: "weekly_recipe", fields: [
      "email",
      "week",
      "day",
      "meal_type",
      "recipe_id",
    ], data: {
      "email": data?["email"],
      "week": data?["week"],
      "day": data?["day"],
      "meal_type": data?["meal_type"],
      "recipe_id": data?["recipe_id"]
    });
    return true;
  }
}
