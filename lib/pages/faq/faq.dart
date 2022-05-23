// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unused_local_variable
import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/faq/helpData.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FAQPage extends StatefulHookConsumerWidget {
  static const String id = '/faq';
  FAQPage({Key? key}) : super(key: key);

  final faqProvider = ChangeNotifierProvider<FaqController>(
    (ref) => FaqController(),
  );

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends ConsumerState<FAQPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      ref.read(widget.faqProvider).displayedItems = kFaqItems;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tec = useTextEditingController();
    Size size = MediaQuery.of(context).size;

    final state = ref.watch(widget.faqProvider);

    // TODO: FAQ Help page, drop down panel of each question,
    // TODO: Functional search bar.

    return CustomPage(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              height: 50,
              width: size.width,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: kcMedGrey,
                width: 1,
                style: BorderStyle.solid,
              ),
              controller: tec,
              margin: const EdgeInsets.all(12),
              onChanged: (value) {
                state.setItemsFromSearchValue(value);
              },
            ),
            ExpansionPanelList.radio(
              animationDuration: Duration(milliseconds: 75),
              dividerColor: Colors.brown[100],
              elevation: 8,
              expandedHeaderPadding: EdgeInsets.only(bottom: 0.0),
              children: state.displayedItems
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
                      body: Container(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: ListTile(
                          subtitle: Text(
                            item.body,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class FaqController extends ChangeNotifier {
  List<Item> _displayedItems = [];
  List<Item> get displayedItems => _displayedItems;

  set displayedItems(List<Item> items) {
    _displayedItems = items;
    notifyListeners();
  }

  void addItem(Item item) {
    _displayedItems.add(item);
  }

  void setItemsFromSearchValue(String val) {
    _displayedItems = [];
    for (Item item in kFaqItems) {
      if (item.header.toUpperCase().contains(val.toUpperCase())) {
        addItem(item);
      }
    }
    notifyListeners();
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
