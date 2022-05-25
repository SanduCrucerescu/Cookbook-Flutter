import 'package:cookbook/db/database_manager.dart';

class DeleteMessage {
  static Future<bool> deteteMessage(
      {required Map<String, dynamic> data}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();

    Future? res =
        dbManager.delete(table: 'comments', where: {"id": data["id"]});
    dbManager.close();
    return true;
  }
}
