import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentsPage extends HookConsumerWidget {
  static const String id = '/comments';

  const CommentsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CustomPage(
      child: Center(
        child: SelectableText('Hello World'),
      ),
    );
  }
}
