import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Member>> getMembers() async {
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
    members.add(curr);
  }
  return members;
}
