import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';

class AddCartIngridients {
  static Future<bool> addToCart({Map<String, dynamic>? cartInfo}) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Future? res = databaseManager.insert(table: "cartingredients", fields: [
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
