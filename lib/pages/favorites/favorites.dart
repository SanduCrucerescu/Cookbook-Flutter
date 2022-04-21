import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritesPage extends HookConsumerWidget {
  static const String id = '/favorites';

  const FavoritesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomPage(
      child: Container(),
    );
  }
}
