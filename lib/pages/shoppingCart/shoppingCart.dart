import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShoppingPage extends HookConsumerWidget {
  static const String id = "/cart";

  const ShoppingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomPage(
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shopping Page",
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: 100,
              width: 100,
            )
          ],
        ),
      ),
    );
  }
}
