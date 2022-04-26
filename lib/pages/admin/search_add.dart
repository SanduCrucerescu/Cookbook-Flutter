import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/delete_user.dart';
import 'package:cookbook/pages/loadimage/load_image.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'admin_page.dart';
import 'alert_box.dart';

class SearchAdd extends HookConsumerWidget {
  final SelectedUserChangeNotifier state;
  const SearchAdd({Key? key, required this.state}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final tec = useTextEditingController();

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      height: 40,
      // width: 400,
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
                      state.filteringString = ''; //  Fix (x) Button
                    },
                    controller: tec,
                    width: 300,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: kcMedBeige,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                addMemberFromAdmin(context);
              },
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/images/add1.png'),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: kcMedBeige,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                areyousure(context, state);
              },
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/images/remove1.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> areyousure(
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
                bool delete = await DeleteUser.Delete(
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
