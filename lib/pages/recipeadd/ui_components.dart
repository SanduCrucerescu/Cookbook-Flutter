import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/pages/recipeadd/dropdown_checkbox.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';

class UiComponents extends HookConsumerWidget {
  UiComponents({Key? key}) : super(key: key);

  final List<String> items = [
    'tbls',
    'tbs',
    'ml',
    'gr',
    'kg',
    'liter',
  ];

  final rowProvider = ChangeNotifierProvider<VerificationChangeNotifier>(
    (ref) => VerificationChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rowProvider);
    Size size = MediaQuery.of(context).size;
    final instructionsController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final topSearchBarController = useTextEditingController();
    final firstRowController = useTextEditingController();

    if (state.rows.isEmpty) {
      state.addRow(buildRow(state: state, controller: firstRowController));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
      child: Center(
        child: ListView(
          controller: ScrollController(),
          children: <Widget>[
            const Center(
              child: SelectableText(
                "Add a recipe",
                style: TextStyle(fontSize: 35),
              ),
            ),
            CustomTextField(
              width: 300,
              height: 60,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              hintText: "Recipe name",
              controller: topSearchBarController,
            ),
            const SelectableText(
              "Ingredients",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 850,
                    child: Table(
                      children: [
                        ...state.rows,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MultilineTextField(
              hintText: "Description",
              controller: descriptionController,
              maxLines: 7,
            ),
            MultilineTextField(
              hintText: 'Instructions',
              controller: instructionsController,
              maxLines: 7,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropDw(
                    tagProvider: rowProvider,
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
              padding: const EdgeInsets.only(top: 10),
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
        TableItem(
          color: Colors.white,
          child: DropdownButton<String>(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            underline: const SizedBox(),
            focusColor: Colors.white,
            isExpanded: true,
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
        TableItem(
          child: CustomTextField(
            height: 45,
            controller: controller,
            hintText: "Amount",
            fontSize: 12,
          ),
        ),
        const TableItem(
          child: Center(
            child: SelectableText(
              "kg",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        TableItem(
          child: FormButton(
            height: 45,
            onTap: () {
              state.setclicked = true;
              state.addRow(
                  buildRow(state: state, controller: TextEditingController()));
              state.popped = state.rows.length;
            },
            text: "Add",
            showShadow: false,
            color: kcLightBeige,
          ),
        ),
        TableItem(
          child: DeleteButton(
            state: state,
            idx: state.rows.length,
          ),
        ),
      ],
    );
  }
}

class TableItem extends StatelessWidget {
  final Widget child;
  final Color? color;
  const TableItem({
    required this.child,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      margin: const EdgeInsets.only(right: 5, top: 2, bottom: 2),
      height: 45,
      color: color,
      child: child,
    );
  }
}

class MultilineTextField extends StatelessWidget {
  final int maxLines;
  final TextEditingController controller;
  final String hintText;

  const MultilineTextField({
    this.maxLines = 1,
    required this.controller,
    this.hintText = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: .5,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: false,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(
              .3,
            ),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DeleteButton extends StatelessWidget {
  final VerificationChangeNotifier state;
  int idx;

  DeleteButton({
    Key? key,
    required this.state,
    required this.idx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.popped != null && idx >= state.popped!) {
      idx -= 1;
    }

    return FormButton(
      height: 45,
      onTap: () {
        state.deleteRow(idx);
      },
      text: "Remove",
      color: kcLightBeige,
      showShadow: false,
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
    popped = idx + 1;
    notifyListeners();
  }

  set text(String val) {
    _text = val;
    notifyListeners();
  }
}
