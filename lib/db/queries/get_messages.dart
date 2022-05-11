import 'package:cookbook/models/post/directMessage/direct_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';

import '../../main.dart';
import '../database_manager.dart';

Future<List<DirectMessage>> getMessages(BuildContext context) async {
  final dbManager = await DatabaseManager.init();
  List<DirectMessage> messages = [];
  Results? res = await dbManager.query(
      query:
          '''SELECT sender, receiver, content, DATE(`time`), TIME_FORMAT(`time`, '%H:%i'), recipeID 
          FROM messages WHERE sender = '${InheritedLoginProvider.of(context).userData!['email']}' OR receiver = '${InheritedLoginProvider.of(context).userData!['email']}' 
          ORDER BY time DESC;''');

  for (var r in res!) {
    final curr = DirectMessage(
        sender: r['sender'].toString(),
        receiver: r['receiver'].toString(),
        content: r['content'].toString(),
        time: r['''TIME_FORMAT(`time`, '%H:%i')'''].toString(),
        date: r['DATE(`time`)'].toString(),
        recipeID: r['recipeID']);

    messages.add(curr); // Something wrong here
  }
  dbManager.close();
  return messages;
}
