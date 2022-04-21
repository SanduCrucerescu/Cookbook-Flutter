import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/pages/recipeadd/ui_components.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';

class MultiSelect extends HookConsumerWidget {
  final List<String> items;

  final ChangeNotifierProvider<VerificationChangeNotifier> tagsProider;

  MultiSelect({Key? key, required this.items, required this.tagsProider})
      : super(key: key);

  void _itemChange(String itemValue, bool isSelected, state) {
    if (isSelected) {
      state.setTags(true);
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
          color: kcLightBeige,
          showShadow: false,
        ),
        FormButton(
          onTap: () {
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

// class MultiSelect extends StatefulWidget {
//   final List<String> items;
//   const MultiSelect({Key? key, required this.items}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
// }

// class _MultiSelectState extends State<MultiSelect> {
//   // this variable holds the selected items
//   final List<String> _selectedItems = [];

// // This function is triggered when a checkbox is checked or unchecked
//   void _itemChange(String itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems.add(itemValue);
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//   }

//   // this function is called when the Cancel button is pressed
//   void _cancel() {
//     Navigator.pop(context);
//   }

// // this function is called when the Submit button is tapped
//   void _submit() {
//     Navigator.pop(context, _selectedItems);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Select Topics'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: widget.items
//               .map((item) => CheckboxListTile(
//                     value: _selectedItems.contains(item),
//                     title: Text(item),
//                     controlAffinity: ListTileControlAffinity.leading,
//                     onChanged: (isChecked) => _itemChange(item, isChecked!),
//                   ))
//               .toList(),
//         ),
//       ),
//       actions: [
//         TextButton(
//           child: const Text('Cancel'),
//           onPressed: _cancel,
//         ),
//         ElevatedButton(
//           child: const Text('Submit'),
//           onPressed: _submit,
//         ),
//       ],
//     );
//   }
// }

// class VerificationChangeNotifier extends ChangeNotifier {
//   List<String> _selectedItems = [];

//   List<String> get selectedItems => _selectedItems;

//   void addTag(String tag) {
//     _selectedItems.add(tag);
//     notifyListeners();
//   }

//   void removeTag(String tag) {
//     _selectedItems.remove(tag);
//     notifyListeners();
//   }
// }
