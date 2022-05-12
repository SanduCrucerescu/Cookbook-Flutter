import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';

class AddCartIngridients {
  static Future<bool> addToCart({Map<String, dynamic>? cartInfo}) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? res =
        await databaseManager.insert(table: "cartingredients", fields: [
      "cart_id",
      "ingredient_id",
      "amount",
    ], data: {
      "cart_id": cartInfo?["cart_id"],
      "ingredient_id": cartInfo?["ingredient_id"],
      "amount": cartInfo?["amount"],
    });
    return true;
  }
}
