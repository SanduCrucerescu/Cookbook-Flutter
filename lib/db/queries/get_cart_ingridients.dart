//TODO this
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Ingredient>?> getCartIngridients(BuildContext context) async {
  if (InheritedLoginProvider.of(context).userData == null) {
    return null;
  }

  var a = InheritedLoginProvider.of(context).userData!['email'];
  a = a.toString(); //here
  final dbManager = await DatabaseManager.init();
  List<Ingredient> ingridients = [];

  Results? res = await dbManager.query(
      query: '''SELECT id,name,unit,amount,pricePerUnit FROM cartingredients 
JOIN ingredients ON ingredients.id=cartingredients.ingredient_id
JOIN members ON members.cart_id=cartingredients.cart_id
WHERE members.email='${a}';''');
  print(a + "here");
  for (var r in res!) {
    final curr = Ingredient(
      id: r['id'],
      name: r['name'],
      unit: r['unit'],
      amount: double.parse(r['amount'].toString()),
      pricePerUnit: r['pricePerUnit'],
    );
    ingridients.add(curr);
  }
  return ingridients;
}

int getCurrentCart(BuildContext context) {
  return InheritedLoginProvider.of(context).userData!['cartID'];
}

class DeleteCart {
  static Future<bool> Delete({
    required String table,
    required Map<String, String> where,
  }) async {
    final DatabaseManager dbManager = await DatabaseManager.init();

    Future? res = dbManager
        .delete(table: "cartingredients", where: {"cart_id": where["cart_id"]});
    dbManager.close();
    return true;
  }
}
