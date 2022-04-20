import 'dart:developer';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/register/register.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Ui_Components extends HookConsumerWidget {
  Ui_Components({Key? key}) : super(key: key);

  final rowPrivider = ChangeNotifierProvider<VerificationChangeNotifier>(
    (ref) => VerificationChangeNotifier(),
  );
  String? selectedValue;
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
              minLines: 4,
            ),
            CustomTextField(
              height: 200,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              hintText: "Instructions",
              controller: useTextEditingController(),
              obscureText: false,
              minLines: 5,
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
        // Padding(
        //   padding: const EdgeInsets.only(right: 10),
        //   child: DropdownButtonHideUnderline(
        //     child: DropdownButton2(
        //       isExpanded: true,
        //       hint: Text("hint"),
        //       items: items
        //           .map((item) => DropdownMenuItem<String>(
        //                 value: item,
        //                 child: Text(
        //                   item,
        //                   style: const TextStyle(
        //                     fontSize: 14,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.grey,
        //                   ),
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ))
        //           .toList(),
        //       value: selectedValue,
        //       onChanged: (value) {
        //         selectedValue = value as String;
        //       },
        //       icon: const Icon(
        //         Icons.arrow_forward_ios_outlined,
        //       ),
        //       buttonDecoration: BoxDecoration(
        //         border: Border.all(
        //           color: Colors.black26,
        //         ),
        //         color: kcLightBeige,
        //       ),
        //       style: TextStyle(fontSize: 18, color: Colors.black),
        //       buttonElevation: 2,
        //       itemHeight: 40,
        //       itemPadding: const EdgeInsets.only(left: 14, right: 14),
        //       dropdownMaxHeight: 200,
        //       dropdownWidth: 200,
        //       dropdownPadding: null,
        //       dropdownDecoration: BoxDecoration(
        //         color: kcLightBeige,
        //       ),
        //       dropdownElevation: 8,
        //       scrollbarRadius: const Radius.circular(40),
        //       scrollbarThickness: 6,
        //       scrollbarAlwaysShow: true,
        //       offset: const Offset(-20, 0),
        //     ),
        //   ),
        // ),
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

class VerificationChangeNotifier extends ChangeNotifier {
  List<TableRow> _rows = [];
  int? popped;
  bool _clicked = false;

  List<TableRow> get rows => _rows;

  bool get clicked => _clicked;

  set setclicked(bool val) {
    _clicked = val;
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
}
