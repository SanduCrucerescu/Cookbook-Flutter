part of components;

const List<String> filterOptions = ['Title', 'Tags', 'Ingredients'];

class CustomPage extends HookConsumerWidget {
  final Widget child;
  final bool showSearchBar;
  final TextEditingController? controller;
  final double searchBarWidth;

  CustomPage({
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
    final loginProvider = InheritedLoginProvider.of(context);
    final tec = controller ?? useTextEditingController();
    final focusNode = useFocusNode();

    focusNode.addListener(
      () async {
        if (!focusNode.hasFocus) {
          // print(expandedState.filterStrings[0] == '');

          loginProvider.setDisplayedRecipes(
            filteringStrings: expandedState.filterStrings,
            filterOption: expandedState.filterOption,
          );
        }
      },
    );
    final bool showFilterStrings = expandedState.filterStrings.isNotEmpty &&
        ['TAGS', 'INGREDIENTS']
            .contains(expandedState.filterOption.toUpperCase());

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: kcLightBeige),
            SideBar(items: kSideBarItems),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                // padding: const EdgeInsets.only(top: 100),
                padding:
                    showFilterStrings ? const EdgeInsets.only(top: 150) : null,
                width: size.width - 200,
                height: size.height - (showFilterStrings ? 0 : 100),
                color: kcLightBeige,
                child: child,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: NavBar(
                focusNode: focusNode,
                searchBarWidth: searchBarWidth,
                controller: tec,
                showSearchBar: showSearchBar,
              ),
            ),
            showFilterStrings
                ? Container(
                    margin: const EdgeInsets.only(top: 100, left: 200),
                    padding: const EdgeInsets.only(top: 15),
                    height: 50,
                    color: kcLightBeige,
                    child: Row(
                      children: [
                        ...expandedState.filterStrings
                            .map((e) => e != ''
                                ? Container(
                                    margin: const EdgeInsets.only(left: 50),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: .5, color: Colors.black),
                                    ),
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        e,
                                        style: ksTitleButtonStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : const SizedBox())
                            .toList()
                      ],
                    ),
                  )
                : const SizedBox(),
            if (expandedState.expanded && showSearchBar == true)
              Positioned(
                top: 80,
                left: size.width / 2 -
                    searchBarWidth / 2 +
                    12.5 +
                    (['INGREDIENTS', 'TAGS']
                            .contains(expandedState.filterOption.toUpperCase())
                        ? -75
                        : 0),
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
                        focusNode: focusNode,
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
    required this.focusNode,
  }) : super(key: key);

  final ExpandedNotifier expandedState;
  final FocusNode focusNode;
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
          expandedState.filterOption = filterOptions[idx].toUpperCase();
          focusNode.requestFocus();
        },
        onHover: (val) {
          hoveringState.toggle();
          focusNode.unfocus();
        },
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
          ),
          child: Center(child: Text(filterOptions[idx])),
        ),
      ),
    );
  }
}
