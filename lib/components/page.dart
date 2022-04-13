part of components;

class CustomPage extends HookConsumerWidget {
  final Widget child;
  final bool? showSearchBar;

  const CustomPage({
    required this.child,
    this.showSearchBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: NavBar(
                showSearchBar: showSearchBar ?? false,
              ),
            ),
            SideBar(items: kSideBarItems),
            Align(
              alignment: Alignment.bottomRight,
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
