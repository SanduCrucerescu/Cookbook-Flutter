import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/comment/comment.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Comment>> getComments({
  int? id,
  bool? nested,
  List<int>? added,
}) async {
  DatabaseManager dbManager = await DatabaseManager.init();

  String q = '''
SELECT post_id as postId,
comments.id as commentId,
comments.member_email as memberEmail,
comments.content as content,
comments.post_comment as isPostComment,
posts.likes,
posts.dislikes 
FROM comments
INNER JOIN posts ON comments.post_id = posts.id
''';

  if (nested != null && nested == true) {
    q += 'WHERE comments.id = $id AND comments.post_comment = false;';
  } else {
    q += id != null
        ? 'WHERE comments.post_id = $id AND comments.post_comment = true;'
        : ';';
  }

  Results? rs = await dbManager.query(query: q);

  added = added ?? [];
  List<Comment> out = [];

  for (ResultRow row in rs!) {
    final fields = row.fields;
    Member member = await getMember(fields['memberEmail']);

    if (added.contains(fields['id'])) {
      continue;
    }

    List<Comment> comments =
        await getComments(id: fields['post_id'], nested: true, added: added);

    Comment curr = Comment(
      id: fields['postId'],
      creator: member,
      content: fields['content'].toString(),
      likes: fields['likes'],
      dislikes: fields['dislikes'],
      comments: comments,
    );
    out.add(curr);
    added.add(curr.id);
  }

  dbManager.close();

  return out;
}
