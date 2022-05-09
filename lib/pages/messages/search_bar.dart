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

    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 60,
      width: (size.width - 300) / 2,
      child: TextField(
        controller: tec,
        onChanged: (value) {
          state.displayedMembers = [];
          state.filteringString = value;
          for (Member member in state.members) {
            if (member.name
                .toUpperCase()
                .startsWith(state.filteringString.toUpperCase())) {
              state.addDisplayedMember(member);
            }
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          hintText: 'Search...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              tec.clear();
              state.filteringString = '';
            },
          ),
        ),
      ),
    );
  }
}
