part of components;

class ExpandedNotifier extends ChangeNotifier {
  String _filterOption = 'TITLE';
  String get filterOption => _filterOption;
  set filterOption(String val) {
    _filterOption = val;
    notifyListeners();
  }

  bool _expanded = false;
  bool get expanded => _expanded;
  set expanded(bool val) {
    _expanded = val;
    notifyListeners();
  }

  void toggle() {
    _expanded = !_expanded;
    notifyListeners();
  }
}

final expandedProvider = ChangeNotifierProvider<ExpandedNotifier>(
  (ref) => ExpandedNotifier(),
);

class NavBar extends HookConsumerWidget {
  final Color backgroundColor;
  final Color widgetColor;
  final String? logoUrl;
  final Image? profilePicture;
  final List<Widget>? actions;
  final Border? border;
  final bool showSearchBar;
  final double? height, width, searchBarHeight;
  final double searchBarWidth;
  final TextEditingController? controller;

  const NavBar({
    this.searchBarWidth = 0,
    this.backgroundColor = kcLightBeige,
    this.widgetColor = kcMedBeige,
    this.logoUrl,
    this.profilePicture,
    this.actions,
    this.border,
    this.showSearchBar = true,
    this.width,
    this.height,
    this.searchBarHeight,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teController = controller ?? useTextEditingController();
    final Map<String?, dynamic>? userData =
        InheritedLoginProvider.of(context).userData;
    final expandedState = ref.watch(expandedProvider);

    Size size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width,
      height: height ?? 100,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border ??
            const Border(
              bottom: BorderSide(
                color: kcMedGrey,
                width: .5,
                style: BorderStyle.solid,
              ),
            ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              NavBarItemBackground(
                width: 110,
                paddingVertical: 10,
                child: CircleAvatar(
                  child: Image.asset('assets/images/temp_logo.png'),
                ),
              ),
              showSearchBar
                  ? Form(
                      onChanged: () {
                        log('changed');
                        InheritedLoginProvider.of(context).setDisplayedRecipes(
                          filteringString: teController.text,
                          filterOption: expandedState.filterOption,
                        );
                      },
                      child: CustomTextField(
                        height: searchBarHeight ?? 60,
                        width: searchBarWidth,
                        backgroundColor: Colors.transparent,
                        margin: const EdgeInsets.only(right: 5),
                        isShadow: false,
                        hintText: 'email',
                        prefixWidget: InkWell(
                          onHover: (val) => expandedState.expanded = true,
                          onTap: () {},
                          child: const Icon(
                            Icons.expand_more,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                        border: Border.all(
                          width: .5,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                        onClickSuffix: () {
                          teController.clear();
                          // state.filteringString = '';
                        },
                        controller: teController,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                    )
                  : const SizedBox(),
              NavBarItemBackground(
                width: 80,
                height: 70,
                child: userData != null
                    ? ProfilePic(
                        member: Member(
                          name: userData['username'],
                          email: userData['email'],
                          password: userData['password'],
                          profilePicture: userData['profilePic'],
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NavBarItemBackground extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final IconData? suffixIcon;
  final double? paddingVertical;
  final EdgeInsets? padding, margin;

  const NavBarItemBackground({
    required this.child,
    Key? key,
    this.borderRadius,
    this.width,
    this.height,
    this.paddingVertical,
    this.suffixIcon,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
        padding: padding ??
            EdgeInsets.symmetric(horizontal: 5, vertical: paddingVertical ?? 0),
        height: height ?? 80,
        width: width ?? 160,
        decoration: BoxDecoration(
          //color: kcMedBeige,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
        child: child,
      ),
    );
  }
}
