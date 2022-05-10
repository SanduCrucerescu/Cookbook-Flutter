part of components;

class CustomPage extends HookConsumerWidget {
  final Widget child;
  final bool showSearchBar;
  final TextEditingController? controller;
  final double? searchBarWidth;

  const CustomPage({
    required this.child,
    this.showSearchBar = false,
    this.controller,
    this.searchBarWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: kcLightBeige,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: NavBar(
                searchBarWidth: searchBarWidth,
                controller: controller,
                showSearchBar: showSearchBar,
              ),
            ),
            SideBar(items: kSideBarItems),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: size.width - 200,
                height: size.height - 100,
                color: kcLightBeige,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
