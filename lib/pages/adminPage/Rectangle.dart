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
<<<<<<< HEAD
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
=======
                      borderRadius: BorderRadius.all(Radius.circular(20))),
>>>>>>> origin/flutter
                  height: 40,
                  width: xSize,
                  alignment: Alignment.topCenter,
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
<<<<<<< HEAD
                  child: Scrollbar(
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    child: ListView.builder(
                        itemCount: 100,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              color: index.isEven
                                  ? Color.fromARGB(240, 204, 165, 165)
                                  : Color.fromARGB(153, 207, 176, 176),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    print("pressed $index");
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
=======
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    alignment: Alignment.center,
                    child: const Text(
                      "Information box",
                    ),
>>>>>>> origin/flutter
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
