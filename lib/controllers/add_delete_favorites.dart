import 'package:mysql1/mysql1.dart';

import '../db/database_manager.dart';

class Favorites {
  static Future<bool> adding({
    String? email,
    int? recipeID,
  }) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? exists = await databaseManager.exists(table: "favorites", fields: [
      "*"
    ], where: {
      "email": email,
      "id": recipeID,
    });

    int exist = 0;

    for (var val in exists!) {
      exist = val[0];
    }

    if (exist == 0) {
      Results? insert =
          await databaseManager.insert(table: "favorites", fields: [
        "email",
        "id"
      ], data: {
        "email": email,
        "id": recipeID,
      });

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> delete({
    String? email,
    int? recipeID,
  }) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();
    Results? delete = await databaseManager.delete(table: "favorites", where: {
      "email": email,
      "id": recipeID,
    });
    return true;
  }
}
