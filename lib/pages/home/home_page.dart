import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  static const String id = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CustomPage(
      child: Center(
        child: Text("Hi"),
      ),
    );
  }
}
