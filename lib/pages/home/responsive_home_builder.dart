part of controllers;

class ResponsiveHomePageBuilder extends ConsumerWidget {
  ResponsiveHomePageBuilder({Key? key}) : super(key: key);

  final widthProider = ChangeNotifierProvider<WidthChangeNotifier>(
    (ref) => WidthChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;

    if (width < 1200) {
      return HomePage.mobile();
    } else if (width < 1680) {
      return HomePage.tablet();
    } else {
      return HomePage.desktop();
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
