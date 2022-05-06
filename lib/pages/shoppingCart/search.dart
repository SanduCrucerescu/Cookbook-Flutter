import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/queries/delete_user.dart';
import 'package:cookbook/pages/loadimage/load_image.dart';
import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
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

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    margin: const EdgeInsets.only(right: 5),
                    isShadow: false,
                    border: Border.all(
                        width: 1,
                        color: Colors.black,
                        style: BorderStyle.solid),
                    onChanged: (value) {
                      state.filteringString = value;
                    },
                    onClickSuffix: () {
                      tec.clear();
                      state.filteringString = '';
                    },
                    controller: tec,
                    width: 300,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
