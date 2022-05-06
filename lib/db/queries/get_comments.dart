import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/post/comment/comment.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Comment>> getComments() async {
  DatabaseManager dbManager = await DatabaseManager.init();

  // Results? rs = await dbManager.select(table: 'comments', fields: ['*']);

  Results? rs = await dbManager.query(query: '''
SELECT id, content, member_email, post.likes, post.dislikes FROM comments
INNER JOIN posts ON comments.post_id = post.id;
''');

  List<Comment> out = [];

  for (ResultRow row in rs!) {
    final fields = row.fields;

    Comment curr = Comment(
      id: fields['id'],
      creator: fields['member_email'],
      content: fields['content'],
      likes: fields['likes'],
      dislikes: fields['dislikes'],
      comments: fields['comments'],
    );
    out.add(curr);
  }

  return out;
}

// Future<List<Comment>> nestedComments(
//     DatabaseManager dbManager, int postId) async {
//   Results? rs = await dbManager.select(table: 'comments', fields: ['id']);

//   List<Comment> out;

//   for (ResultRow row in rs!) {
//     if (row.fields['post_id'] == postId) {
//       await nestedComments(dbManager, row.fields['post_id']);
//     }
//   }

//   return out;
// }
