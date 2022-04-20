import 'dart:html';

import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/post.dart';

class DirectMessage extends Post {
  DirectMessage(
      {required Member creator,
      required String content,
      required int likes,
      required int dislikes,
      required List<Comment> comments})
      : super(
            creator: creator,
            content: content,
            likes: likes,
            dislikes: dislikes,
            comments: comments);
}
