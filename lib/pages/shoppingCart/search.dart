import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/queries/delete_user.dart';
import 'package:cookbook/pages/loadimage/load_image.dart';
import 'package:cookbook/pages/shoppingCart/shopping_page.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchIngridient extends HookConsumerWidget {
  final SelectedIngridientChangeNotifier state;
  const SearchIngridient({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tec = useTextEditingController();
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 50,
      child: CustomTextField(
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(right: 5),
        isShadow: false,
        hintText: 'ingredient',
        border: Border.all(
          width: .5,
          color: Colors.black,
          style: BorderStyle.solid,
        ),
        onChanged: (value) {
          state.filteringString = value;
        },
        onClickSuffix: () {
          tec.clear();
          state.filteringString = ''; //  Fix (x) Button
        },
        controller: tec,
        width: 300,
        height: 200,
        // borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
