import 'package:cookbook/components/components.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/directMessage/direct_message.dart';
import 'package:cookbook/pages/messages/message_textfield.dart';
import 'package:cookbook/pages/messages/search_bar.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../db/queries/get_members.dart';
import '../../db/queries/get_messages.dart';
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
      final state = ref.read(membersProvider);
      state.members = await getMembers(context);
      state.displayedMembers = state.members;
      state.messages = await getMessages();
      // for (Member member in state.displayedMembers) {
      //   if (member.email ==
      //       InheritedLoginProvider.of(context).userData?['email']) {
      //     state.removeDisplayedMember(member);
      //   }
      // }
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
    final messageTec = useTextEditingController();

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
                    SearchBar(state: state, tec: tec),
                    Container(
                      height: size.height - 200,
                      width: (size.width - 200) / 2,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListView.builder(
                        controller: sc1,
                        itemCount: state.displayedMembers.length,
                        itemBuilder: (BuildContext context, int idx) {
                          return InboxWidget(idx: idx, state: state);
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !state.toggle,
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
                  visible: state.toggle,
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
                        itemCount: state.displayedMessages.length,
                        itemBuilder: (BuildContext context, int idx) {
                          return ConversationWidget(
                            idx: idx,
                            state: state,
                          );
                        },
                      ),
                    ),
                    MessageTextField(
                      state: state,
                      messageTec: messageTec,
                    ),
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
  List<Member> _displayedMembers = [];
  List<DirectMessage> _messages = [];
  List<DirectMessage> _displayedMessages = [];
  String _filteringString = '';
  String _message = '';
  bool _toggle = false;
  late int _idx;

  String get filteringString => _filteringString;

  String get message => _message;

  List<Member> get members => _members;

  List<Member> get displayedMembers => _displayedMembers;

  List<DirectMessage> get messages => _messages;

  bool get toggle => _toggle;

  int get idx => _idx;

  List<DirectMessage> get displayedMessages => _displayedMessages;

  set members(List<Member> newMember) {
    _members = newMember;
    notifyListeners();
  }

  set displayedMembers(List<Member> newMember) {
    _displayedMembers = newMember;
    notifyListeners();
  }

  set messages(List<DirectMessage> newMessage) {
    _messages = newMessage;
    notifyListeners();
  }

  set displayedMessages(List<DirectMessage> newMessage) {
    _displayedMessages = newMessage;
    notifyListeners();
  }

  set filteringString(String val) {
    _filteringString = val;
    notifyListeners();
  }

  set message(String val) {
    _message = val;
    notifyListeners();
  }

  set toggle(bool cond) {
    _toggle = cond;
    notifyListeners();
  }

  set idx(int idx) {
    _idx = idx;
    notifyListeners();
  }

  void removeMember(Member member) {
    _members.remove(member);
    notifyListeners();
  }

  void addMember(Member _member) {
    _members.add(_member);
    notifyListeners();
  }

  void addDisplayedMember(Member _member) {
    _displayedMembers.add(_member);
    notifyListeners();
  }

  void removeDisplayedMember(Member _member) {
    _displayedMembers.remove(_member);
    notifyListeners();
  }

  void addDisplayedMessage(DirectMessage _message) {
    _displayedMessages.add(_message);
    notifyListeners();
  }

  void removeDisplayedMessage(DirectMessage _message) {
    _displayedMessages.remove(_message);
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
