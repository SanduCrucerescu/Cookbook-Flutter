import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/recipeadd/ui_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Recipe_Add extends ConsumerWidget {
  static const String id = "/addrecipe";

  Recipe_Add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    return CustomPage(
      child: Ui_Components(),
    );
  }
}
