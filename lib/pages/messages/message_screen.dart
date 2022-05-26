import 'package:binary_tree/binary_tree.dart';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/queries/get_recipes.dart';
import 'package:cookbook/db/queries/send_message.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/directMessage/direct_message.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/pages/messages/message_textfield.dart';
import 'package:cookbook/pages/messages/search_bar.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiver/iterables.dart';

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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final state = ref.watch(membersProvider);
      state.members = await getMembers(context);
      state.messages = await getMessages(context);
      state.advancedSetDisplayedMembers(state.members, context);
      GetRecepies getRecepies = GetRecepies();
      getRecepies.getrecep();
      state._recipes = getRecepies.recepieList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController sc1 = useScrollController();
    ScrollController sc2 = useScrollController();
    Size size = MediaQuery.of(context).size;
    final searchBarController = useTextEditingController();
    final messageController = useTextEditingController();
    final state = ref.watch(membersProvider);

    return CustomPage(
      child: Row(
        children: [
          Column(
            children: [
              SearchBar(state: state, tec: searchBarController),
              Container(
                height: size.height - 200,
                width: (size.width - 200) / 2,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                  controller: sc1,
                  physics: const BouncingScrollPhysics(),
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
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
                  width: (size.width - 200) / 2,
                  controller: messageController,
                  regularMessage: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final membersProvider = ChangeNotifierProvider<MessagePageController>(
  (ref) => MessagePageController(),
);

class MessagePageController extends ChangeNotifier {
  List<Member> _members = [];
  List<Member> _displayedMembers = [];
  List<Member> _shareMembers = [];
  List<DirectMessage> _messages = [];
  List<DirectMessage> _displayedMessages = [];
  List<Recipe> _recipes = [];

  String _filteringString = '';
  String _message = '';
  bool _toggle = false;
  late int _idx;
  String _date = '';

  String get filteringString => _filteringString;

  String get message => _message;

  String get date => _date;

  List<Member> get members => _members;

  List<Member> get displayedMembers => _displayedMembers;

  List<Member> get shareMembers => _shareMembers;

  List<DirectMessage> get messages => _messages;

  List<Recipe> get recipes => _recipes;

  bool get toggle => _toggle;

  int get idx => _idx;

  List<DirectMessage> get displayedMessages => _displayedMessages;

  bool earlier(String initial, String other) {
    var chars1 = initial.split('-: ').map((e) => int.parse(e)).toList();
    var chars2 = other.split('-: ').map((e) => int.parse(e)).toList();

    for (var pair in zip([chars1, chars2])) {
      if (pair[0] < pair[1]) {
        return false;
      }
    }

    return true;
  }

  set members(List<Member> newMember) {
    _members = newMember;
    notifyListeners();
  }

  set displayedMembers(List<Member> newMembers) {
    _displayedMembers = newMembers;
    notifyListeners();
  }

  set shareMembers(List<Member> newMembers) {
    _shareMembers = newMembers;
    notifyListeners();
  }

  set recipes(List<Recipe> newRecipes) {
    _recipes = newRecipes;
    notifyListeners();
  }

  Member? getMemberByEmail(String? email) {
    for (Member m in _members) {
      if (m.email == email) {
        return m;
      }
    }
  }

  void advancedSetDisplayedMembers(
    List<Member> newMembers,
    BuildContext context,
  ) {
    List<Member> membersWithChat = [];
    List<DirectMessage> lastMessages = [];
    final String email = InheritedLoginProvider.of(context).userData!['email'];
    for (DirectMessage mes in _messages) {
      final mem = getMemberByEmail(
        mes.sender != email ? mes.sender : mes.receiver,
      );
      if ((mes.sender == email || mes.receiver == email) &&
          !membersWithChat.contains(mem) &&
          mem != null) {
        membersWithChat.add(mem);
        lastMessages.add(mes);
      }
    }

    final orderedMessages = BinaryTree<DirectMessage>();
    List<Member> orderedMembersWithChat = [];

    for (DirectMessage dm in lastMessages) {
      orderedMessages.insert(dm);
    }

    for (DirectMessage dm in orderedMessages.toList()) {
      orderedMembersWithChat.add(membersWithChat.elementAt(membersWithChat
          .indexWhere((e) => e.email == dm.receiver || e.email == dm.sender)));
      // print(dm.toString());
    }

    for (Member _member in membersWithChat) {
      newMembers.remove(_member);
    }

    _displayedMembers = [...membersWithChat, ...newMembers];
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

  set date(String val) {
    _date = val;
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

  void addShareMember(Member _member) {
    _shareMembers.add(_member);
    notifyListeners();
  }

  void removeShareMember(Member _member) {
    _shareMembers.remove(_member);
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

  Recipe? getRecipe(int id) {
    for (Recipe r in recipes) {
      if (r.id == id) {
        return r;
      }
    }
    return null;
  }
}
