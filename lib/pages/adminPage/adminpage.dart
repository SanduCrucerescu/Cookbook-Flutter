import 'package:cookbook/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'Rectangle.dart';

class Admin extends ConsumerWidget {
  static const String id = "/admin";

  Admin({Key? key}) : super(key: key);
  final selectUserProvider = ChangeNotifierProvider<SelectedUserChangeNotifier>(
    (ref) => SelectedUserChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectUserProvider);

    Size size = MediaQuery.of(context).size;
    // TODO: In Login Screen make Username: Admin return this page
    return (Scaffold(
      backgroundColor: Color(0xFFE3DBCA),
      body: Stack(
        children: [
          NavBar(),
          SideBar(items: kSideBarItems),
          Padding(
            padding: const EdgeInsets.fromLTRB(200, 50, 0, 0),
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
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class SelectedUserChangeNotifier extends ChangeNotifier {
  int _idx = -1;

  int get idx => _idx;

  set idx(int val) {
    _idx = val;
    notifyListeners();
  }
}
