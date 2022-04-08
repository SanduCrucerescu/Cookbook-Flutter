import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomButton extends HookConsumerWidget {
  final Duration duration;

  const CustomButton({
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: duration,
      color: kcDarkBlue,
    );
  }
}
