import '../database_manager.dart';

class SendMessage {
  static Future<bool> sendMessage(
      {required Map<String, dynamic> data, required bool isLink}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();
    if (isLink == true) {
      Future? res = dbManager.insert(
          table: 'messages',
          fields: ['sender', 'receiver', 'content', 'time', 'recipeID'],
          data: data);
      dbManager.close();
      return true;
    } else {
      Future? res = dbManager.insert(
          table: 'messages',
          fields: ['sender', 'receiver', 'content', 'time'],
          data: data);
      dbManager.close();
      return true;
    }
  }
}
