import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';

class AddCartIngridients {
  static Future<bool> addToCart({Map<String, dynamic>? cartInfo}) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Future? res = databaseManager.insert(table: "cartingredients", fields: [
      "cart_id",
      "ingredients_for_recipe_id",
      "quantity",
    ], data: {
      "cart_id": cartInfo?["cart_id"],
      "ingredients_for_recipe_id": cartInfo?["ingredients_for_recipe_id"],
      "quantity": cartInfo?["quantity"],
    });
    return true;
  }
}
