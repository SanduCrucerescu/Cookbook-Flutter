import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CenterScrollField extends HookConsumerWidget {
  const CenterScrollField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class RecipePost extends HookConsumerWidget {
  final Duration duration;

  const RecipePost({
    required this.duration,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: duration,
    );
  }
}
