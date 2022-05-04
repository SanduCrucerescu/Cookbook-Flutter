import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Ingredient>> getIngridients() async {
  final dbManager = await DatabaseManager.init();
  List<Ingredient> ingridients = [];
  Results? res = await dbManager.select(table: 'ingredients', fields: ['*']);
//TODO this
  for (var r in res!) {
    final curr = Ingredient(
      id: r['id'],
      name: r['name'],
      unit: r['unit'],
      // amount: r['amount'],
      pricePerUnit: r['pricePerUnit'],
    );
    ingridients.add(curr);
  }
  return ingridients;
}
