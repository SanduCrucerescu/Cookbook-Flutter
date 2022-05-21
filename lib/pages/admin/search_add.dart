import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/queries/delete_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'admin_page.dart';
import 'alert_box.dart';

class SearchAdd extends HookConsumerWidget {
  final SelectedUserChangeNotifier state;
  const SearchAdd({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tec = useTextEditingController();

    return SizedBox(
      height: 50,
      // width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomTextField(
              backgroundColor: Colors.transparent,
              margin: const EdgeInsets.only(right: 5),
              isShadow: false,
              hintText: 'email',
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
          ),
          Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              // color: kcMedBeige,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: .1),
            ),
            child: InkWell(
              onTap: () {
                addMemberFromAdmin(context);
              },
              child: const Center(
                child: Icon(
                  Icons.add_outlined,
                  size: 40,
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              // color: kcMedBeige,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: .1),
            ),
            child: InkWell(
              onTap: () {
                confirmationDialog(context, state);
              },
              child: const Center(
                child: Icon(
                  Icons.remove_outlined,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> confirmationDialog(
      BuildContext context, SelectedUserChangeNotifier state) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Delete User")),
          content: Text("Are you sure you want to delete User ${state.email}?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Abort'),
              child: const Text('Abort',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () async {
                await DeleteUser.Delete(
                    table: "memebers", where: {"email": state.email});
                Navigator.pop(context, "Delete");
              },
              // Replace with query
              child: const Text('Delete',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
