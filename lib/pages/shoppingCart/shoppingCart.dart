import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShoppingPage extends HookConsumerWidget {
  static const String id = "/cart";

  ShoppingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomPage(
      child: Row(),
    );
  }
}
