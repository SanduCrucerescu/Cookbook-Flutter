import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Ingredient>> getIngredients() async {
  final dbManager = await DatabaseManager.init();
  List<Ingredient> ingridients = [];

  Results? res = await dbManager.select(table: 'ingredients', fields: ['*']);
//TODO this
  for (var r in res!) {
    final curr = Ingredient(
      id: r['id'],
      name: r['name'],
      unit: r['unit'],
      amount: r['amount'] ?? 1,
      pricePerUnit: r['pricePerUnit'],
    );
    ingridients.add(curr);
  }
  dbManager.close();
  return ingridients;
}
