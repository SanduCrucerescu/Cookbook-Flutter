part of components;

const List<String> filterOptions = ['Name', 'Tags', 'Ingredients'];

class CustomPage extends HookConsumerWidget {
  final Widget child;
  final bool showSearchBar;
  final TextEditingController? controller;
  final double searchBarWidth;

  const CustomPage({
    required this.child,
    this.showSearchBar = false,
    this.controller,
    this.searchBarWidth = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final expandedState = ref.watch(expandedProvider);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: kcLightBeige),
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
            Align(
              alignment: Alignment.topCenter,
              child: NavBar(
                searchBarWidth: searchBarWidth,
                controller: controller,
                showSearchBar: showSearchBar,
              ),
            ),
            expandedState.expanded && showSearchBar == true
                ? Positioned(
                    top: 70,
                    left: size.width / 2 - searchBarWidth / 2,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 40.0 * filterOptions.length,
                      width: 200,
                      child: ListView.builder(
                        itemCount: filterOptions.length,
                        itemBuilder: (context, idx) => InkWell(
                          onTap: () {
                            expandedState.toggle();
                            print(expandedState.filterOption);
                            expandedState.filterOption = filterOptions[idx];
                            print(expandedState.filterOption);
                          },
                          onHover: (val) {},
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              color: kcLightBeige,
                              border:
                                  Border.all(width: .5, color: Colors.black),
                            ),
                            margin: const EdgeInsets.only(left: 20, bottom: 1),
                            child: Center(child: Text(filterOptions[idx])),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
