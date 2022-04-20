part of components;

class CustomPage extends HookConsumerWidget {
  final Widget child;
  final bool? showSearchBar;
  final TextEditingController? controller;

  const CustomPage({
    required this.child,
    this.showSearchBar,
    this.controller,
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
                controller: controller,
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
