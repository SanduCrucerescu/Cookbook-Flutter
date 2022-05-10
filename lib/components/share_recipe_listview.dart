import 'package:cookbook/pages/messages/inbox_widget.dart';
import 'package:cookbook/pages/messages/message_screen.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShareListview extends StatefulHookConsumerWidget {
  const ShareListview({Key? key}) : super(key: key);

  @override
  _ShareListViewState createState() => _ShareListViewState();
}

class _ShareListViewState extends ConsumerState<ShareListview> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(membersProvider);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - 450,
      width: (size.width - 100) / 3,
      child: ListView.builder(
          itemCount: state.displayedMembers.length,
          itemBuilder: (BuildContext context, int idx) {
            return Container(
              margin: const EdgeInsets.only(top: 2),
              height: 50,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: kcLightBeige),
              child: ListTile(
                leading: ProfilePic(
                  member: state.displayedMembers[idx],
                  height: 40,
                  width: 40,
                ),
                title: Text(state.displayedMembers[idx].name),
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (!state.shareMembers
                        .contains(state.displayedMembers[idx])) {
                      state.addShareMember(state.displayedMembers[idx]);
                    }
                  },
                ),
              ),
            );
          }),
    );
  }
}
