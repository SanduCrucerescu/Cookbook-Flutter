import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
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
        ));
  }
}
