import 'dart:html';

import 'package:cookbook/models/member/member.dart';

class Post {
  final int id;
  final Member creator;
  String content;
  int likes;
  int dislikes;
  List<Comment> comments;

  Post(
      {required this.id,
      required this.creator,
      required this.content,
      required this.likes,
      required this.dislikes,
      required this.comments});

  int get getId => id;

  Member get getCreator => creator;

  String get getContent => content;

  int get getLikes => likes;

  int get getDislikes => dislikes;

  List<Comment> get getComments => comments;

  void set id(int id) {
    this.id = id;
  }

  void set creator(Member creator) {
    this.creator = creator;
  }

  void set setContent(String content) {
    this.content = content;
  }

  void set setLikes(int likes) {
    this.likes = likes;
  }

  void set setDislikes(int dislikes) {
    this.dislikes = dislikes;
  }

  void set setComments(List<Comment> comments) {
    this.comments = comments;
  }

  void addComment() {}

  void removeComment() {}
}
