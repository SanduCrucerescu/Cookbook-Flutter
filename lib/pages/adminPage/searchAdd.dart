import 'package:cookbook/components/components.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'adminpage.dart';
import 'alertbox.dart';

class searchadd extends HookConsumerWidget {
  final SelectedUserChangeNotifier state;
  const searchadd({Key? key, required this.state}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final tec = useTextEditingController();

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      height: 40,
      width: 400,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 5, 0),
            child: Container(
              height: 40,
              width: 40,
              color: kcMedBeige,
              child: InkWell(
                onTap: () => addMemberFromAdmin(context),
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('assets/images/add.png'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            color: kcMedBeige,
            child: InkWell(
              onTap: () {
                areyousure(context);
              },
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/images/Remove.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> areyousure(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Delete User")),
          content: Text("Are you sure you want to delete User ${state.idx}?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Abort', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, 'OK'), // Replace with query
              child: const Text('Delete',
                  style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
