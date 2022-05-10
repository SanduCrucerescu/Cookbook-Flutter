import '../database_manager.dart';

class SendMessage {
  static Future<bool> sendMessage({required Map<String, dynamic> data}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();

    Future? res = dbManager.insert(
        table: 'messages',
        fields: ['sender', 'receiver', 'content', 'time'],
        data: data);
    dbManager.close();
    return true;
  }
}
