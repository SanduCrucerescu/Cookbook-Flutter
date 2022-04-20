import 'package:cookbook/pages/adminPage/adminpage.dart';
import 'package:cookbook/pages/adminPage/searchAdd.dart';
import 'package:cookbook/pages/adminPage/userTile.dart';
import 'package:flutter/material.dart';

class Rectangle extends StatelessWidget {
  final String text;
  final SelectedUserChangeNotifier state;
  final position;

  const Rectangle({
    required this.text,
    required this.state,
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double xSize = 600;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            // Height and width of the boxes
            height: 850,
            width: 600,
            //Title of the rectangle
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  searchadd(state: state),
                  UsersBox(state: state),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded UsersBox({required SelectedUserChangeNotifier state}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Scrollbar(
          isAlwaysShown: true,
          showTrackOnHover: true,
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (BuildContext context, int idx) {
              return UserTile(
                state: state,
                idx: idx,
              );
            },
          ),
        ),
      ),
    );
  }
}
