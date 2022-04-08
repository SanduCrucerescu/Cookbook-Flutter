import 'package:cookbook/pages/home/navbar.dart';
import 'package:cookbook/pages/home/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  static const String id = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController tec = useTextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment.topRight,
              child: NavBar(),
            ),
            SideBar(),
            const Center(
              child: SelectableText("hi"),
            ),
          ],
        ),
      ),
    );
  }
}
