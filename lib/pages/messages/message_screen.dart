import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/messages/message_textfield.dart';
import 'package:cookbook/pages/messages/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'conversation_widget.dart';
import 'inbox_widget.dart';

class MessagePage extends HookConsumerWidget {
  static const String id = "/messages";

  final messagesProvider = ChangeNotifierProvider<MessagesChangeNotifier>(
    (ref) => MessagesChangeNotifier(),
  );

  MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController sc1 = useScrollController();
    ScrollController sc2 = useScrollController();
    final state = ref.watch(messagesProvider);
    Size size = MediaQuery.of(context).size;
    final tec = useTextEditingController();

    return Scaffold(
      body: Container(
        color: const Color(0xFFE3DBCA),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            const NavBar(
              showSearchBar: false,
            ),
            Row(
              children: [
                SideBar(
                  items: kSideBarItems,
                  margin: const EdgeInsets.all(0),
                ),
                Column(
                  children: [
                    const SearchBar(),
                    Container(
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
                    ),
                  ],
                ),
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black)),
                    height: size.height - 200,
                    width: (size.width - 200) / 2,
                    margin: const EdgeInsets.only(bottom: 3),
                    child: ListView.builder(
                      controller: sc2,
                      reverse: true,
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int idx) {
                        return ConversationWidget(idx: idx);
                      },
                    ),
                  ),
                  const MessageTextField(),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesChangeNotifier extends ChangeNotifier {
  // List<Message> _messages = [];
  //
  // List<Message> get message => _messages;
  //
  // set message(List<Message> newMessages) {
  //   _messages = newMessages;
  //   notifyListeners();
  // }
}

class T extends StatefulWidget {
  const T({Key? key}) : super(key: key);

  @override
  State<T> createState() => _TState();
}

class _TState extends State<T> {
  late ScrollController sc1;

  @override
  void initState() {
    sc1 = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      controller: sc1,
      children: [],
    ));
  }

  @override
  void dispose() {
    sc1.dispose();
    super.dispose();
  }
}
