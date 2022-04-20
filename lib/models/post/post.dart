import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/comment/comment.dart';

class Post {
  final Member creator;
  String content;
  int likes;
  int dislikes;
  List<Comment> comments;

  Post(
      {required this.creator,
      required this.content,
      required this.likes,
      required this.dislikes,
      required this.comments});

  void addComment() {}

  void removeComment() {}
}
