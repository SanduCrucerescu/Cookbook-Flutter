import 'package:cookbook/controllers/controllers.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'pages/loading/loading_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class InheritedLoginProviderWrapper extends StatefulWidget {
  final Widget child;
  const InheritedLoginProviderWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<InheritedLoginProviderWrapper> createState() =>
      _InheritedLoginProviderWrapperState();
}

class _InheritedLoginProviderWrapperState
    extends State<InheritedLoginProviderWrapper> {
  Map<String?, dynamic>? userData;
  bool isLoggedIn = false;
  String currPageID = LoadingScreen.id;

  void update() {
    setState(() {
      isLoggedIn = false;
      isLoggedIn = true;
    });
  }

  void setIsLoggedIn(bool val, Map<String?, dynamic> newUserData) {
    setState(() {
      isLoggedIn = val;
      userData = newUserData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedLoginProvider(
      child: widget.child,
      data: this,
      isLoggedIn: isLoggedIn,
    );
  }
}

class InheritedLoginProvider extends InheritedWidget {
  final bool isLoggedIn;
  final Widget child;
  final _InheritedLoginProviderWrapperState data;

  const InheritedLoginProvider({
    required this.data,
    required this.isLoggedIn,
    required this.child,
    Key? key,
  }) : super(key: key, child: child);

  static _InheritedLoginProviderWrapperState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedLoginProvider>()!
        .data;
  }

  @override
  bool updateShouldNotify(covariant InheritedLoginProvider oldWidget) {
    return isLoggedIn != oldWidget.isLoggedIn;
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cookbook',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: kcPrimaryGreen,
      ),
      initialRoute: LoadingScreen.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
