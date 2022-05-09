import 'package:cookbook/models/post/directMessage/direct_message.dart';
import 'package:mysql1/mysql1.dart';

import '../database_manager.dart';

Future<List<DirectMessage>> getMessages() async {
  final dbManager = await DatabaseManager.init();
  List<DirectMessage> messages = [];
  Results? res = await dbManager.query(
      query:
          '''SELECT sender, receiver, content, DATE(`time`), TIME_FORMAT(`time`, '%H:%i') 
          FROM messages WHERE sender = 'abolandr@gnu.org' OR receiver = 'abolandr@gnu.org' 
          ORDER BY time DESC;''');

  for (var r in res!) {
    final curr = DirectMessage(
        sender: r['sender'],
        receiver: r['receiver'],
        content: r['content'].toString(),
        time: r['''TIME_FORMAT(`time`, '%H:%i')'''].toString(),
        date: r['DATE(`time`)'].toString());

    messages.add(curr); // Something wrong here
  }
  return messages;
}
