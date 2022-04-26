import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/get_members.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/messages/message_textfield.dart';
import 'package:cookbook/pages/messages/search_bar.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'conversation_widget.dart';
import 'inbox_widget.dart';

class MessagePage extends StatefulHookConsumerWidget {
  static const String id = "/messages";

  const MessagePage({Key? key}) : super(key: key);

  @override
  MessagePageState createState() => MessagePageState();
}

class MessagePageState extends ConsumerState<MessagePage> {
  final membersProvider = ChangeNotifierProvider<MessagePageController>(
    (ref) => MessagePageController(),
  );

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      ref.read(membersProvider).members = await getMembers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController sc1 = useScrollController();
    ScrollController sc2 = useScrollController();
    final state = ref.watch(membersProvider);
    Size size = MediaQuery.of(context).size;
    final tec = useTextEditingController();
    bool _toggle = false;

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
                        itemCount: state.members.length,
                        itemBuilder: (BuildContext context, int idx) {
                          return InboxWidget(idx: idx, state: state);
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !_toggle,
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kcLightBeige,
                        border: Border.all(color: Colors.black),
                      ),
                      height: size.height - 200,
                      width: (size.width - 200) / 2,
                      child: const Center(
                        child: Text(
                          "No Conversation Selected",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                Visibility(
                  visible: _toggle,
                  child: Column(children: [
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
                          return ConversationWidget(
                            idx: idx,
                            state: state,
                          );
                        },
                      ),
                    ),
                    const MessageTextField(),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessagePageController extends ChangeNotifier {
  List<Member> _members = [];

  List<Member> get members => _members;

  set members(List<Member> newMember) {
    _members = newMember;
    notifyListeners();
  }

  void removeMember(int idx) {
    _members.removeAt(idx);
    notifyListeners();
  }

  void addMember(Member _member) {
    _members.add(_member);
    notifyListeners();
  }
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
