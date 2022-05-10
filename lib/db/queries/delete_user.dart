import 'package:cookbook/db/database_manager.dart';

class DeleteUser {
  static Future<bool> Delete({
    required String table,
    required Map<String, String> where,
  }) async {
    final DatabaseManager dbManager = await DatabaseManager.init();

    Future? res =
        dbManager.delete(table: "members", where: {"email": where["email"]});
    dbManager.close();
    return true;
  }
}
