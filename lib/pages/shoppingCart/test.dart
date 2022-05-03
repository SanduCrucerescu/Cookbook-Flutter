import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/shoppingCart/shoppingCart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngridientsApp extends ConsumerWidget {
  IngridientsApp({Key? key}) : super(key: key);

  final sp = ChangeNotifierProvider<ShoppingPageController>(
    (ref) => ShoppingPageController(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sp);

    return MaterialApp(
      home: IngridientsRow(
        state: state,
      ),
    );
  }
}

class IngridientsRow extends StatefulWidget {
  final ShoppingPageController state;

  const IngridientsRow({required this.state, Key? key}) : super(key: key);

  @override
  State<IngridientsRow> createState() => _IngridientsRowState();
}

class _IngridientsRowState extends State<IngridientsRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int idx) {
              return Container();
            }));
  }
}
