import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userPageProvider = ChangeNotifierProvider<UserPageController>(
  (ref) => UserPageController(),
);

class UserPageController extends ChangeNotifier {
  Map<String, dynamic>? _data = {};
  bool _saved = false;
  String _text = "";

  String get text => this._text;

  set text(String value) {
    _text = value;
    notifyListeners();
  }

  bool get saved => _saved;

  set saved(bool value) {
    _saved = value;
    notifyListeners();
  }

  Map<String, dynamic>? get data => _data;

  set data(Map<String, dynamic>? newData) {
    _data = newData;
    notifyListeners();
  }
}
