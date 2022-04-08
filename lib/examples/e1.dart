import 'package:flutter/material.dart';

class E1 extends StatelessWidget {
  final String text;
  final Widget child;
  const E1({
    Key? key,
    required this.child,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(text),
          child,
        ],
      ),
    );
  }
}

class E2 extends StatelessWidget {
  const E2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return E1(
      text: "Im E1",
      child: Container(
        height: 50,
        width: 50,
        color: Colors.blue,
      ),
    );
  }
}

class E3 extends StatelessWidget {
  const E3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return E1(
      text: "Im E1",
      child: TextButton(
        onPressed: () {},
        child: const Text("Click me"),
      ),
    );
  }
}
