import 'dart:io';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/admin/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'rectangle.dart';

class Admin extends HookConsumerWidget {
  static const String id = "/admin";

  Admin({Key? key}) : super(key: key);

  final selectUserProvider = ChangeNotifierProvider<SelectedUserChangeNotifier>(
    (ref) => SelectedUserChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectUserProvider);
    final tec = useTextEditingController();
    Size size = MediaQuery.of(context).size;

    return CustomPage(
      child: Row(
        children: [
          Expanded(
            child: Rectangle(
              state: state,
              text: "User List",
              position: Alignment.topLeft,
            ),
          ),
          Expanded(
            child: UserInfo(
              state: state,
              text: "Current User",
              position: Alignment.topRight,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedUserChangeNotifier extends ChangeNotifier {
  int _idx = -1;
  Member? _currMember;
  String _userName = "";
  String _email = "";
  Image image = Image.asset("assets/images/ph.png"); // doesnt count
  String _filteringString = '';
  File? _xFile;

  String get filteringString => _filteringString;

  int get idx => _idx;

  String get email => _email;

  String get userName => _userName;

  Member? get currMember => _currMember;
  File? get file => _xFile;

  set currMember(Member? member) {
    _currMember = member;
    notifyListeners();
  }

  set filteringString(String val) {
    _filteringString = val;
    notifyListeners();
  }

  set idx(int val) {
    _idx = val;
    notifyListeners();
  }

  set email(String val) {
    _email = val;
    notifyListeners();
  }

  set userName(String val) {
    _userName = val;
    notifyListeners();
  }

  set path(File? path) {
    _xFile = path;
    notifyListeners();
  }
}
