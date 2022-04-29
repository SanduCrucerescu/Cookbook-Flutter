import 'package:cookbook/models/post/directMessage/direct_message.dart';
import 'package:mysql1/mysql1.dart';

import '../db/database_manager.dart';

Future<List<DirectMessage>> getMessages() async {
  final dbManager = await DatabaseManager.init();
  List<DirectMessage> messages = [];
  Results? res = await dbManager.select(
      table: 'messages',
      fields: [
        'sender',
        'receiver',
        'content',
        '''TIME_FORMAT(`time`, '%H:%i')''',
        'DATE(`time`)'
      ],
      where: {'sender': 'abolandr@gnu.org', 'receiver': 'abolandr@gnu.org'},
      or: "or");

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
