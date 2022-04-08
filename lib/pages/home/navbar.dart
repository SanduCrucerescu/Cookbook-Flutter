import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBar extends HookConsumerWidget {
  const NavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      width: size.width - 230,
      height: 100,
      decoration: BoxDecoration(
        color: kcMedBlue,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
