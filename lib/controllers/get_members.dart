import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Member>> getMembers(BuildContext context) async {
  final dbManager = await DatabaseManager.init();
  List<Member> members = [];
  Results? res = await dbManager.select(table: 'members', fields: ['*']);

  for (var r in res!) {
    final curr = Member(
      name: r['username'],
      email: r['email'],
      password: r['password'],
      profilePicture: r['profile_pic'],
    );
    if (!(InheritedLoginProvider.of(context).userData!['email'] == curr.email))
      members.add(curr);
  }
  return members;
}
