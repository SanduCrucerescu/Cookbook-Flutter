import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/comment/comment.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Comment>> getComments({int? id, bool? nested}) async {
  DatabaseManager dbManager = await DatabaseManager.init();

  String q = '''
SELECT post_id, comments.id, comments.member_email, comments.content, posts.likes, posts.dislikes 
FROM comments
INNER JOIN posts ON comments.post_id = posts.id
''';

  if (nested != null) {
    q += ' WHERE comments.post_id = $id;';
  } else {
    q += id != null ? ' WHERE comments.id = $id;' : ';';
  }

  Results? rs = await dbManager.query(query: q);

  List<Comment> out = [];

  for (ResultRow row in rs!) {
    final fields = row.fields;
    Member member = await getMember(fields['member_email']);
    List<Comment> comments = await getComments(id: fields['id'], nested: true);

    Comment curr = Comment(
      id: fields['post_id'],
      creator: member,
      content: fields['content'].toString(),
      likes: fields['likes'],
      dislikes: fields['dislikes'],
      comments: comments,
    );
    out.add(curr);
  }

  dbManager.close();

  return out;
}
