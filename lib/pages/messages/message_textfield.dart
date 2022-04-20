import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
            height: 60,
            width: (size.width - 200) / 2,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                hintText: 'Enter message',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    print("hello");
                  },
                ),
              ),
            )),
      ],
    );
  }
}
