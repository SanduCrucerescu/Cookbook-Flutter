import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userPageProvider = ChangeNotifierProvider<UserPageController>(
  (ref) => UserPageController(),
);

class UserPageController extends ChangeNotifier {
  Map<String, dynamic>? _data = {};

  Map<String, dynamic>? get data => _data;

  set data(Map<String, dynamic>? newData) {
    _data = newData;
    notifyListeners();
  }
}
