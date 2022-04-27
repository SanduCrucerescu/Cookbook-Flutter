import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/member/member.dart';
import 'message_screen.dart';

class SearchBar extends StatelessWidget {
  final MessagePageController state;
  final TextEditingController tec;

  const SearchBar({Key? key, required this.state, required this.tec})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: 60,
        width: (size.width - 300) / 2,
        child: TextField(
          controller: tec,
          onChanged: (value) {
            state.filteringString = value;
            for (Member member in state.members) {
              if (member.name.startsWith(state.filteringString) &&
                  state.filteringString != "" &&
                  !state.displayedMembers.contains(member)) {
                state.addDisplayedMember(member);
              } else if (!member.name.startsWith(state.filteringString)) {
                state.removeDisplayedMember(member);
              }
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
            hintText: 'Search...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                print(state.displayedMembers.toString());
              },
            ),
          ),
        ));
  }
}
