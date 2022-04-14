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
              border: Border.all(
                color: Colors.red,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: 1000,
            width: 400,
            //Title of the rectangle
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  height: 40,
                  width: xSize,
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.square(80),
                          primary: Colors.black, // NEW
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Remove",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.square(80),
                          primary: Colors.black, // NEW
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: index.isEven
                              ? const Color.fromARGB(240, 204, 165, 165)
                              : const Color.fromARGB(153, 207, 176, 176),
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
                                    padding: const EdgeInsets.symmetric(),
                                    child: CircleAvatar(
                                      child:
                                          Image.asset('assets/images/ph.png'),
                                    ),
                                  ),
                                  const Text(
                                    "Username",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                border: Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: 1000,
            width: 400,
            //Title of the rectangle
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
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
