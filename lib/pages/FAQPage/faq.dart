// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  static const String id = '/faq';
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  static const sampleText = 'lorem ipsum dolor sit amet...';
  final List<Item> items = [
    Item(header: 'What can I do as a user?', body: sampleText),
    Item(header: 'How do I add a recipe?', body: sampleText),
    Item(header: 'How to favorite a recipe?', body: sampleText),
    Item(header: 'How to add a recipe to your cart?', body: sampleText),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: FAQ Help page, drop down panel of each question
    return CustomPage(
      child: SizedBox(
        width: size.width - 200,
        height: size.height - 100,
        // Search bar

        // FAQ drop down list
        child: SingleChildScrollView(
          child: ExpansionPanelList.radio(
            animationDuration: Duration(milliseconds: 75),
            dividerColor: Colors.brown[100],
            elevation: 8,
            children: items
                .map(
                  (item) => ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: item.header,
                    headerBuilder: (context, isExpanded) => ListTile(
                      title: Text(
                        item.header,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    body: ListTile(
                      title: Text(
                        item.body,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String header;
  final String body;

  Item({
    required this.header,
    required this.body,
  });
}
