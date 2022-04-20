import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/adminPage/adminpage.dart';
import 'package:cookbook/pages/adminPage/alertbox.dart';
import 'package:cookbook/theme/colors.dart';
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
                  searchadd(),
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

class UserTile extends StatelessWidget {
  // TODO final Member member;
  final int idx;
  final SelectedUserChangeNotifier state;

  const UserTile({
    // TODO required this.member,
    required this.idx,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        color: idx.isEven
            ? const Color.fromARGB(255, 245, 245, 220)
            : const Color.fromARGB(255, 245, 245, 220),
        child: Padding(
          // Size of the user boxes (icon and name)
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: CircleAvatar(
                    child: Image.asset('assets/images/ph.png'),
                  ),
                ),
                const Text(
                  "Username",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String text;
  final position;
  final SelectedUserChangeNotifier state;

  const UserInfo({
    required this.text,
    required this.position,
    required this.state,
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
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          height: 850,
          width: 600,
          //Title of the rectangle
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                height: 40,
                width: xSize,
                alignment: Alignment.topCenter,
                child: Text(
                  "${state.idx}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                    "Name: ${state.userName}\nEmail: ${state.email}\nImage: ${state.image}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class searchadd extends StatelessWidget {
  const searchadd({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        height: 40,
        width: 400,
        child: Expanded(
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        width: 300,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 5, 0),
                child: Expanded(
                  child: Container(
                    height: 40,
                    width: 40,
                    color: kcMedBeige,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset('assets/images/add.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                color: kcMedBeige,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/images/Remove.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
