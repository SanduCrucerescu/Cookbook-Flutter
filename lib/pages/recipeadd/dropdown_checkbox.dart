import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/queries/add_tag.dart';
import 'package:cookbook/pages/recipeadd/ui_components.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Future<dynamic> addTad(BuildContext context, state) {
    TextEditingController controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add a new tag"),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomTextField(
                  hintText: "Tag name",
                  controller: controller,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  duration: const Duration(milliseconds: 200),
                  onTap: () async {
                    if (controller.text.isEmpty) {
                    } else {
                      bool val = await AddTag.addTag(table: "tags", data: {
                        "name": controller.text,
                      });
                      state.addTags(controller.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Add Tag",
                  ),
                  width: 150,
                  height: 50,
                )
              ],
            )
          ],
        );
      },
    );
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
        const SizedBox(
          height: 10,
        ),
        FormButton(
          onTap: () {
            addTad(context, state);
          },
          text: "Add a new tag",
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
  //final List<String> items = [];

  DropDw({
    Key? key,
    required this.tagProvider,
  }) : super(key: key);

  void showMultiSelect(BuildContext context, state) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? res =
        await databaseManager.select(table: "tags", fields: ["name"]);

    for (var rs in res!) {
      state.addTags(rs[0]);
    }

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: state.items,
          tagsProider: tagProvider,
        );
      },
    );

    if (results != null) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tagProvider);
    return Column(
      children: [
        FormButton(
          onTap: () {
            showMultiSelect(context, state);
          },
          text: "Show tags",
          color: kcDarkBeige,
          showShadow: false,
        ),
      ],
    );
  }
}
