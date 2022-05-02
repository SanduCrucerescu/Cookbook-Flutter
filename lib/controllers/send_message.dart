import '../db/database_manager.dart';

class SendMessage {
  static Future<bool> sendMessage({required Map<String, dynamic> data}) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Future? res = databaseManager.insert(
        table: 'messages',
        fields: ['sender', 'receiver', 'content', 'time'],
        data: data);

    return true;
  }
}
