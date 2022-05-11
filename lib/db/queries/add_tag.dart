import 'package:cookbook/db/database_manager.dart';
import 'package:mysql1/mysql1.dart';

class AddTag {
  static Future<bool> addTag(
      {required String table, Map<String, dynamic>? data}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();

    Results? res = await dbManager
        .insert(table: table, fields: ["name"], data: {"name": data!["name"]});
    dbManager.close();
    return true;
  }
}
