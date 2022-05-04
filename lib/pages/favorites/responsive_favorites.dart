import 'package:cookbook/pages/favorites/favorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponsiveFavoritesPage extends ConsumerWidget {
  ResponsiveFavoritesPage({Key? key}) : super(key: key);

  final widthProider = ChangeNotifierProvider<WidthChangeNotifier>(
    (ref) => WidthChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;

    if (width < 1200) {
      return FavoritesPage.mobile();
    } else if (width < 1680) {
      return FavoritesPage.tablet();
    } else {
      return FavoritesPage.desktop();
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
