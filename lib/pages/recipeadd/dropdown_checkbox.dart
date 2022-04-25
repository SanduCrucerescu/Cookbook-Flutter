import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/recipeadd/ui_components.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';

import '../../db/database_manager.dart';

class MultiSelect extends HookConsumerWidget {
  final List<String> items;
  final ChangeNotifierProvider<VerificationChangeNotifier> tagsProider;

  const MultiSelect({
    Key? key,
    required this.items,
    required this.tagsProider,
  }) : super(key: key);

  void _itemChange(String itemValue, bool isSelected, state) {
    if (isSelected) {
      state.setTags(true);
      state.noTags = false;
      state.addTag(itemValue);
    } else {
      state.removeTag(itemValue);
    }
  }

  void _cancel(BuildContext context) {
    Navigator.pop(context);
  }

  void _submit(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tagsProider);
    return AlertDialog(
      title: const Text('Select Tags'),
      content: SingleChildScrollView(
        child: ListBody(
          children: items
              .map((item) => CheckboxListTile(
                    value: state.selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) =>
                        _itemChange(item, isChecked!, state),
                  ))
              .toList(),
        ),
      ),
      actions: [
        FormButton(
          onTap: () {
            _submit(context);
          },
          text: "Submit",
          color: kcDarkBeige,
          showShadow: false,
        ),
        FormButton(
          onTap: () {
            state.clearTags();
            _cancel(context);
          },
          text: "Cancel",
          color: Colors.white,
          showShadow: false,
        )
      ],
    );
  }
}

class DropDw extends HookConsumerWidget {
  final ChangeNotifierProvider<VerificationChangeNotifier> tagProvider;
  List<String> _selectedItems = [];
  final List<String> items = [];

  DropDw({
    Key? key,
    required this.tagProvider,
  }) : super(key: key);

  void showMultiSelect(BuildContext context) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? res =
        await databaseManager.select(table: "tags", fields: ["name"]);

    for (var rs in res!) {
      items.add(rs[0]);
    }

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: items,
          tagsProider: tagProvider,
        );
      },
    );

    if (results != null) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        FormButton(
          onTap: () {
            showMultiSelect(context);
          },
          text: "Show tags",
          color: kcDarkBeige,
          showShadow: false,
        ),
      ],
    );
  }
}
