import 'package:cookbook/models/post/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentsController extends ChangeNotifier {
  List<Comment>? _comments;

  List<Comment>? get comments => _comments;

  void addComment(Comment comment) {
    if (_comments != null) _comments!.add(comment);
  }

  void removeComment(Comment comment) {
    if (_comments != null) _comments!.remove(comment);
  }

  void update() => notifyListeners();

  set comments(List<Comment>? newComments) {
    _comments = newComments;
    notifyListeners();
  }
}

final commentsProvider = ChangeNotifierProvider<CommentsController>(
  (ref) => CommentsController(),
);
