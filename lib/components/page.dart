part of components;

class CustomPage extends HookConsumerWidget {
  final Widget child;

  const CustomPage({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment.topCenter,
              child: NavBar(),
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
