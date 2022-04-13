import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';

class Rectangle extends StatelessWidget {
  final String text;
  final position;

  const Rectangle({
    required this.text,
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double xSize = 400;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 1000,
            width: 400,
            //Title of the rectangle
            child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 40,
                    width: xSize,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            hintText: "Search user",
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          )),
                          TextButton(
                            onPressed: () {},
                            child: Image.asset('assets/images/add.png'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Remove",
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size.square(80),
                              primary: Colors.black, // NEW
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              color: index.isEven
                                  ? Color.fromARGB(255, 245, 245, 220)
                                  : Color.fromARGB(255, 245, 200, 220),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text("$index"),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(),
                                        child: CircleAvatar(
                                          child: Image.asset(
                                              'assets/images/ph.png'),
                                        ),
                                      ),
                                      Text(
                                        "Username",
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),
                )
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

  const UserInfo({
    required this.text,
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double xSize = 400;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            height: 1000,
            width: 400,
            //Title of the rectangle
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  height: 40,
                  width: xSize,
                  alignment: Alignment.topCenter,
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Expanded(
                    child: Text("Username\nRecipies\nOther info"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
