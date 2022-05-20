import 'dart:io';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/components/sidebar_items.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/admin/user_info.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';
import '../login/login.dart';
import 'rectangle.dart';

class Admin extends HookConsumerWidget {
  static const String id = "/admin";
  final bool showSearchBar;
  final TextEditingController? controller;
  final double? searchBarWidth;

  Admin(
      {this.showSearchBar = false,
      this.controller,
      this.searchBarWidth,
      Key? key})
      : super(key: key);

  final selectUserProvider = ChangeNotifierProvider<SelectedUserChangeNotifier>(
    (ref) => SelectedUserChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectUserProvider);
    final tec = useTextEditingController();
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: kcLightBeige),
            Align(
              alignment: Alignment.topCenter,
              child: NavBar(
                searchBarWidth: searchBarWidth,
                controller: controller,
                showSearchBar: showSearchBar,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: size.width - 200,
                height: size.height - 100,
                color: kcLightBeige,
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
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.only(bottom: 30, right: 30),
                child: CustomButton(
                    color: kcDarkBeige,
                    width: 200,
                    onTap: () {
                      Navigator.of(context).pushNamed(LoginPage.id);
                    },
                    duration: const Duration(milliseconds: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/lock_open.png",
                          fit: BoxFit.fill,
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Log Out"),
                      ],
                    )),
              ),
            )
          ],
        ),
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
  late Blob _photo;

  String get filteringString => _filteringString;

  int get idx => _idx;

  String get email => _email;

  String get userName => _userName;

  Member? get currMember => _currMember;
  File? get file => _xFile;
  Blob get photo => _photo;

  set text(text) {}
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

  set photo(Blob file) {
    _photo = file;
    notifyListeners();
  }
}
