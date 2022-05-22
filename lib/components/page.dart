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
            if (expandedState.expanded && showSearchBar == true)
              Positioned(
                top: 80,
                left: size.width / 2 - searchBarWidth / 2 + 13,
                child: MouseRegion(
                  onEnter: (event) => expandedState.expanded = true,
                  onExit: (event) => expandedState.expanded = false,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kcLightBeige,
                      border: Border(
                        left: BorderSide(width: .5, color: Colors.black),
                        right: BorderSide(width: .5, color: Colors.black),
                        bottom: BorderSide(width: .5, color: Colors.black),
                      ),
                      // borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.all(10),
                    height: 30.0 * filterOptions.length + 21,
                    width: 200,
                    child: ListView.builder(
                      controller: ScrollController(),
                      itemCount: filterOptions.length,
                      itemBuilder: (context, idx) => FilterOptionDropDownItem(
                        expandedState: expandedState,
                        idx: idx,
                      ),
                    ),
                  ),
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class FilterOptionDropDownItem extends ConsumerWidget {
  FilterOptionDropDownItem({
    Key? key,
    required this.expandedState,
    required this.idx,
  }) : super(key: key);

  final ExpandedNotifier expandedState;
  final int idx;

  final hoveringProvider = ChangeNotifierProvider(
    (ref) => HoveringNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoveringState = ref.watch(hoveringProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      child: InkWell(
        onTap: () {
          expandedState.toggle();
          expandedState.filterOption = filterOptions[idx];
        },
        onHover: (val) => hoveringState.toggle(),
        child: Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            color: kcLightBeige,
            border: hoveringState.hovering
                ? Border.all(width: 1.5, color: Colors.black)
                : idx != 0
                    ? const Border(
                        top: BorderSide(width: .5, color: Colors.black))
                    : null,
            // : Border.all(width: .5, color: Colors.black),
          ),
          // margin: const EdgeInsets.only(left: 20, bottom: 1),
          child: Center(child: Text(filterOptions[idx])),
        ),
      ),
    );
  }
}
