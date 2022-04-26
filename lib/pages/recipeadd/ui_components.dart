import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/add_recipe.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/pages/recipeadd/DropDown.dart';
import 'package:cookbook/pages/recipeadd/dropdown_checkbox.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late String img64;

  late List<CustDropdownMenuItem<String>> menuItems = [
    const CustDropdownMenuItem(
      child: Text(''),
      value: '',
    )
  ];

  final rowProvider = ChangeNotifierProvider<VerificationChangeNotifier>(
    (ref) => VerificationChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rowProvider);
    _getIngredients();
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
            state.ingredientValidator
                ? Center(
                    child: SelectableText(
                      state.t,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  )
                : const SizedBox(),
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
                    onTap: () {
                      _openImagePicker(state);
                    },
                    text: "Select Photo",
                    showShadow: false,
                    color: kcDarkBeige,
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
                      "Photo added: " + state.text,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  )
                : const SizedBox(),
            state.noTags
                ? Center(
                    child: SelectableText(
                      state.t,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  )
                : const SizedBox(),
            state.noInput
                ? Center(
                    child: SelectableText(
                      state.t,
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
                  onTap: () async {
                    if (topSearchBarController.text == "" ||
                        descriptionController.text == "" ||
                        instructionsController.text == "" ||
                        state.ingredints.isEmpty) {
                      state.noInput = true;
                      state.t = "Please fill all the fields";
                    } else {
                      state.noInput = false;
                      if (state.selectedItems.isEmpty) {
                        state.noTags = true;
                        state.t = "Please add some tags";
                      } else {
                        // if (state.file == null) {
                        //   ByteData bytes =
                        //       await rootBundle.load('assets/images/ph.png');
                        //   Uint8List photobytes = bytes.buffer.asUint8List(
                        //       bytes.offsetInBytes, bytes.lengthInBytes);

                        //   img64 = base64Encode(photobytes);
                        // } else {
                        //   final bytes = state.file?.readAsBytesSync();
                        //   img64 = base64Encode(bytes!);
                        // }
                        final bytes = state.file?.readAsBytesSync();
                        var d = bytes!.toList();
                        bool add = await AddRecipe.adding(
                            recipeInfo: {
                              "title": topSearchBarController.text,
                              "description": descriptionController.text,
                              "instructions": instructionsController.text,
                              "member_email": "abolandr@gnu.org",
                              "picture": d.toString()
                            },
                            ingredients: state.ingredientsMap,
                            tags: state.selectedItems);
                      }
                    }
                  },
                  text: "Submit",
                  color: kcDarkBeige,
                  showShadow: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void _getIngredients() async {
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? res = await databaseManager
        .select(table: "ingredients", fields: ["id", "name"]);

    for (var rs in res!) {
      menuItems.add(CustDropdownMenuItem(
        child: Text(rs[1]),
        value: "${rs[0]}",
      ));
    }
  }

  TableRow buildRow({
    required VerificationChangeNotifier state,
    required TextEditingController controller,
  }) {
    return TableRow(
      children: [
        TableItem(
          color: Colors.white,
          // child: DropDown(
          //   menuItems: menuItems,
          //   state: state,
          // ),
          child: CustDropDown(
            items: menuItems,
            onChanged: (val) {
              state.addingredints(val);
              print(state.ingredints);
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
              //print(state.ingredints.isEmpty);
              if (state.ingredints.isEmpty) {
                state.ingredientValidator = true;
                state.t = "Please select an ingredient";
              } else {
                if (controller.text.isEmpty) {
                  state.ingredientValidator = true;
                  state.t = "Please insert an amount or ingredient";
                } else {
                  if (!_isNumeric(controller.text)) {
                    state.ingredientValidator = true;
                    state.t = "Please use numbers for the ammount";
                  } else {
                    state.ingredientValidator = false;
                    state.addRow(buildRow(
                        state: state, controller: TextEditingController()));
                    state.popped = state.rows.length;
                    state.addMap(state.ingredints[state.rows.length - 2],
                        int.parse(controller.text));
                  }
                }
              }
            },
            text: "Add",
            showShadow: false,
            color: kcDarkBeige,
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

void _openImagePicker(VerificationChangeNotifier state) async {
  final typeGroup = XTypeGroup(
    label: 'images',
    extensions: const ['jpg', 'jpeg', 'png', 'heic'],
  );

  final xFile = await openFile(acceptedTypeGroups: [typeGroup]);
  if (xFile != null) {
    state.imageAdded = true;
    state.text = xFile.name;

    File file = File(xFile.path);
    state.path = file;
    Blob blob = Blob.fromBytes(await file.readAsBytes());
    state.photo = blob;
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
      color: kcDarkBeige,
      showShadow: false,
    );
  }
}

class VerificationChangeNotifier extends ChangeNotifier {
  List<TableRow> _rows = [];
  List<String> _selectedItems = [];
  List<String> _ingredints = [];
  Map<String, int> _ingredientsMap = {};
  List<String> _items = [];

  String _t = "";
  int? popped;
  bool _imageAdded = false;
  bool _tagsAdded = false;
  bool _noTags = false;
  bool _ingredientValidator = false;
  bool _noInput = false;
  String _text = "";
  late Blob _photo;
  File? _xFile;

  List<TableRow> get rows => _rows;

  bool get imageAdded => _imageAdded;

  bool get tagsAdded => _tagsAdded;

  String get text => _text;

  List<String> get selectedItems => _selectedItems;

  File? get file => _xFile;

  Blob get photo => _photo;

  String get t => _t;

  List<String> get ingredints => _ingredints;

  Map<String, int> get ingredientsMap => _ingredientsMap;

  bool get noTags => _noTags;

  bool get ingredientValidator => _ingredientValidator;

  bool get noInput => _noInput;

  List<String> get items => _items;

  void addTag(String tag) {
    _selectedItems.add(tag);
    notifyListeners();
  }

  void removeTag(String tag) {
    _selectedItems.remove(tag);
    notifyListeners();
  }

  void clearTags() {
    _tagsAdded = false;
    _selectedItems.clear();
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

  set imageAdded(bool val) {
    _imageAdded = val;
    notifyListeners();
  }

  set photo(Blob file) {
    _photo = file;
    notifyListeners();
  }

  set path(File? path) {
    _xFile = path;
    notifyListeners();
  }

  set t(String t) {
    _t = t;
    notifyListeners();
  }

  set value(int value) {
    value = value;
    notifyListeners();
  }

  void addingredints(String val) {
    _ingredints.add(val);
    notifyListeners();
  }

  void addMap(String key, int value) {
    _ingredientsMap.addAll({key: value});
    notifyListeners();
  }

  set noTags(bool val) {
    _noTags = val;
    notifyListeners();
  }

  set ingredientValidator(bool val) {
    _ingredientValidator = val;
    notifyListeners();
  }

  set noInput(bool val) {
    _noInput = val;
    notifyListeners();
  }

  void addTags(String tag) {
    _items.add(tag);
    notifyListeners();
  }
}
