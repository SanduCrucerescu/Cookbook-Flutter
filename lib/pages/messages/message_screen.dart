import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    return Scaffold(
      body: Container(
        color: Colors.grey[300],
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
                    SizedBox(
                        height: 60,
                        width: (size.width - 300) / 2,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: 'Search...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                print("hello");
                              },
                            ),
                          ),
                        )),
                    Container(
                      height: size.height - 200,
                      width: (size.width - 200) / 2,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListView.builder(
                        controller: sc1,
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int idx) {
                          return MessageWidget(idx: idx, state: state);
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
                  Row(
                    children: [
                      SizedBox(
                          height: 60,
                          width: (size.width - 200) / 2,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(),
                              hintText: 'Enter message',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  print("hello");
                                },
                              ),
                            ),
                          )),
                    ],
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final int idx;
  final MessagesChangeNotifier state;

  const MessageWidget({
    required this.state,
    required this.idx,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 100,
      width: size.width / 4,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          print("Helo");
        },
        onHover: (val) {
          print(val);
        },
        child: ListTile(
          leading: CircleAvatar(
            child: Image.asset('assets/images/ph.png'),
          ),
          title: Text("$idx"),
          subtitle: const Text("Some message"),
          trailing: Container(
            height: 30,
            width: 30,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(primary: Colors.black),
              child: Text("X"),
            ),
          ),
        ),
      ),
    );
  }
}

class ConversationWidget extends StatelessWidget {
  final int idx;

  const ConversationWidget({
    required this.idx,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 100,
      width: size.width / 4,
      child: ListTile(
        leading: CircleAvatar(
          child: Image.asset('assets/images/ph.png'),
        ),
        title: Text("$idx"),
        trailing: Text("3:45"),
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
