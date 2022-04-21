import 'dart:developer';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/recipeadd/dropdown_checkbox.dart';
import 'package:cookbook/pages/register/register.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';

import '../../db/database_manager.dart';

class Ui_Components extends HookConsumerWidget {
  Ui_Components({Key? key}) : super(key: key);

  final rowPrivider = ChangeNotifierProvider<VerificationChangeNotifier>(
    (ref) => VerificationChangeNotifier(),
  );

  String? _firstValue;
  List<String> items = [
    'tbls',
    'tbs',
    'ml',
    'gr',
    'kg',
    'liter',
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rowPrivider);
    Size size = MediaQuery.of(context).size;

    if (state.rows.isEmpty) {
      state.addRow(
          buildRow(state: state, controller: useTextEditingController()));
    }

    return Container(
      height: size.height - 100,
      width: size.width - 200,
      padding: const EdgeInsets.all(80),
      child: Center(
        child: ListView(
          children: <Widget>[
            const Center(
              child: Text(
                "Add a recipe",
                style: TextStyle(fontSize: 35),
              ),
            ),
            CustomTextField(
              width: 300,
              height: 60,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              hintText: "Recipe name",
              controller: useTextEditingController(),
              obscureText: false,
            ),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 850,
                    child: Table(
                      //border: TableBorder.all(color: Colors.black),
                      children: [
                        ...state.rows,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomTextField(
              height: 180,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              hintText: "Description",
              controller: useTextEditingController(),
              obscureText: false,
              maxLines: 4,
            ),
            CustomTextField(
              height: 200,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              hintText: "Instructions",
              controller: useTextEditingController(),
              obscureText: false,
              maxLines: 5,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropDw(
                    tagProvider: rowPrivider,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FormButton(
                    onTap: () {},
                    text: "Select Photo",
                    showShadow: false,
                    color: kcLightBeige,
                  ),
                ],
              ),
            ),
            state.tagsAdded
                ? Wrap(
                    children: state.selectedItems
                        .map((e) => Chip(label: Text(e)))
                        .toList(),
                  )
                : const SizedBox(),
            state.imageAdded
                ? Center(
                    child: SelectableText(
                      state.text,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: FormButton(
                  onTap: () {
                    print(state.selectedItems);
                  },
                  text: "Submit",
                  color: kcLightBeige,
                  showShadow: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TableRow buildRow({
    required VerificationChangeNotifier state,
    required TextEditingController controller,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: DropdownButton<String>(
            hint: const Text("foo"),
            items: const [
              DropdownMenuItem(
                value: 'foo',
                child: Text('Foo'),
              ),
              DropdownMenuItem(
                value: 'bar',
                child: Text('Bar'),
              ),
            ],
            onChanged: (val) {
              print(val);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomTextField(
            height: 40,
            hintText: "Amount",
            controller: controller,
            obscureText: false,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text("unit of measure"),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: FormButton(
            onTap: () {
              state.setclicked = true;
              state.addRow(
                  buildRow(state: state, controller: TextEditingController()));
              //print(state.rows.rem);
            },
            text: "Add",
            showShadow: false,
            color: kcLightBeige,
          ),
        ),
        RowButton(
          state: state,
          idx: state.rows.length,
        ),
      ],
    );
  }
}

class RowButton extends StatelessWidget {
  final VerificationChangeNotifier state;
  int idx;

  RowButton({
    Key? key,
    required this.state,
    required this.idx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.popped != null && idx > state.popped!) {
      idx--;
    }

    print(idx);
    return FormButton(
      onTap: () {
        state.deleteRow(idx);
        //print(state.rows.asMap());
      },
      text: "Remove",
      color: kcLightBeige,
      showShadow: false,
    );
  }
}

class DropDw extends HookConsumerWidget {
  final tagProvider;

  DropDw({Key? key, required this.tagProvider}) : super(key: key);
  List<String> _selectedItems = [];
  final List<String> items = [];

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
    final state = ref.watch(tagProvider);
    return Column(
      children: [
        FormButton(
          onTap: () {
            showMultiSelect(context);
          },
          text: "Show tags",
          color: kcLightBeige,
          showShadow: false,
        ),
      ],
    );
  }
}

class VerificationChangeNotifier extends ChangeNotifier {
  List<TableRow> _rows = [];
  List<String> _selectedItems = [];

  int? popped;
  bool _imageAdded = false;
  bool _tagsAdded = false;
  String _text = "";

  List<TableRow> get rows => _rows;

  bool get imageAdded => _imageAdded;

  bool get tagsAdded => _tagsAdded;

  String get text => _text;

  List<String> get selectedItems => _selectedItems;

  void addTag(String tag) {
    _selectedItems.add(tag);
    notifyListeners();
  }

  void removeTag(String tag) {
    _selectedItems.remove(tag);
    notifyListeners();
  }

  set setclicked(bool val) {
    _imageAdded = val;
    notifyListeners();
  }

  void setTags(bool val) {
    _tagsAdded = val;
    notifyListeners();
  }

  void addRow(TableRow row) {
    if (rows.isEmpty) {
      _rows.add(row);
    } else {
      _rows.add(row);
      notifyListeners();
    }
  }

  void deleteRow(int idx) {
    _rows.removeAt(idx);
    popped = idx;
    notifyListeners();
  }

  set text(String val) {
    _text = val;
    notifyListeners();
  }
}
