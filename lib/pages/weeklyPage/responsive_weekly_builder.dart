import 'package:cookbook/pages/home/home_page.dart';
import 'package:cookbook/pages/weeklyPage/weekly_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponsiveWeeklyPageBuilder extends ConsumerWidget {
  ResponsiveWeeklyPageBuilder({Key? key}) : super(key: key);

  final widthProider = ChangeNotifierProvider<WidthChangeNotifier>(
    (ref) => WidthChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;

    if (width < 1200) {
      return WeeklyPage.mobile();
    } else if (width < 1680) {
      return WeeklyPage.tablet();
    } else {
      return WeeklyPage.desktop();
    }
  }
}

class WidthChangeNotifier extends ChangeNotifier {
  double _width = 0;

  double get width => _width;

  set width(double val) {
    _width = val;
    notifyListeners();
  }
}
