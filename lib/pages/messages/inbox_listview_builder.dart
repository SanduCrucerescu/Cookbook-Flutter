import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'inbox_widget.dart';
import 'message_screen.dart';

class InboxBuilder extends StatelessWidget {
  InboxBuilder({Key? key}) : super(key: key);
  final messagesProvider = ChangeNotifierProvider<MessagesChangeNotifier>(
    (ref) => MessagesChangeNotifier(),
  );

  @override
  Widget build(BuildContext context) {
    ScrollController sc1 = useScrollController();
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(messagesProvider);

    return Container(
      height: size.height - 200,
      width: (size.width - 200) / 2,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
        controller: sc1,
        itemCount: 20,
        itemBuilder: (BuildContext context, int idx) {
          return InboxWidget(idx: idx, state: state);
        },
      ),
    );
  }
}
