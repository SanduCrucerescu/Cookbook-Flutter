import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Ingredient>> getIngridients() async {
  final dbManager = await DatabaseManager.init();
  List<Ingredient> ingridients = [];
  Results? res = await dbManager.select(table: 'ingridients', fields: ['*']);
//TODO this
  for (var r in res!) {
    final curr = Ingredient(
      r['id'],
      r['name'],
      r['unit'],
      r['amount'],
      r['pricePerUnit'],
    );
    ingridients.add(curr);
  }
  return ingridients;
}
