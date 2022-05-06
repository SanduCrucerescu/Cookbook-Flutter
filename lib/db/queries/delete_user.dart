import 'package:cookbook/db/database_manager.dart';

class DeleteUser {
  static Future<bool> Delete({
    required String table,
    required Map<String, String> where,
  }) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Future? res = databaseManager
        .delete(table: "members", where: {"email": where["email"]});

    return true;
  }
}
