part of components;

class ExpandedNotifier extends ChangeNotifier {
  List<String> _filterStrings = [];
  List<String> get filterStrings => _filterStrings;
  set filterStrings(List<String> val) {
    _filterStrings = val;
    notifyListeners();
  }

  void addFilterString(String val) {
    _filterStrings.add(val);
    notifyListeners();
  }

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
  final FocusNode? focusNode;

  const NavBar({
    this.focusNode,
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
    final loginProvider = InheritedLoginProvider.of(context);
    final expandedState = ref.watch(expandedProvider);

    print('Rebuilding');

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
                      onChanged: () async {
                        switch (expandedState.filterOption.toUpperCase()) {
                          case 'TITLE':
                            expandedState.filterStrings = [teController.text];

                            // loginProvider.setDisplayedRecipes(
                            //   filteringStrings: expandedState.filterStrings,
                            //   filterOption: expandedState.filterOption,
                            // );

                            break;
                          // case 'INGREDIENTS':
                          //   if (expandedState.filterStrings.length > 1) {
                          //     expandedState.filterStrings[0] =
                          //         teController.text;
                          //   } else if (expandedState.filterStrings.isEmpty) {
                          //     expandedState.filterStrings = [''];
                          //   }
                          //   loginProvider.setDisplayedRecipes(
                          //     filteringStrings: expandedState.filterStrings,
                          //     filterOption: expandedState.filterOption,
                          //   );
                          //   break;
                          // case 'TAGS':
                          //   if (expandedState.filterStrings.length > 1) {
                          //     expandedState.filterStrings[0] =
                          //         teController.text;
                          //   } else if (expandedState.filterStrings.isEmpty) {
                          //     expandedState.filterStrings = [''];
                          //   }
                          //   print(expandedState.filterStrings);
                          //   loginProvider.setDisplayedRecipes(
                          //     filteringStrings: expandedState.filterStrings,
                          //     filterOption: expandedState.filterOption,
                          //   );
                          //   break;
                        }
                      },
                      child: Row(
                        children: [
                          CustomTextField(
                            duration: const Duration(milliseconds: 0),
                            focusNode: focusNode,
                            height: searchBarHeight ?? 60,
                            width: searchBarWidth,
                            backgroundColor: Colors.transparent,
                            margin: const EdgeInsets.only(right: 5),
                            isShadow: false,
                            hintText: 'Search by ${expandedState.filterOption}',
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
                            },
                            onChanged: (val) {
                              if (expandedState.filterOption.toUpperCase() ==
                                  'TITLEdaskd') {
                                loginProvider.setDisplayedRecipes(
                                  filteringStrings: [teController.text],
                                  filterOption: 'TITLE',
                                );
                              }

                              focusNode != null
                                  ? focusNode!.requestFocus()
                                  : {};
                            },
                            onSubmitted: () {
                              if (expandedState.filterOption.toUpperCase() ==
                                  'TITLE') {
                                expandedState.filterStrings = [
                                  teController.text.toUpperCase()
                                ];
                                loginProvider.setDisplayedRecipes(
                                  filteringStrings: expandedState.filterStrings,
                                  filterOption: expandedState.filterOption,
                                );
                              }
                              focusNode != null
                                  ? focusNode!.requestFocus()
                                  : {};
                            },
                            controller: teController,
                          ),
                          [
                            'INGREDIENTS',
                            'TAGS'
                          ].contains(expandedState.filterOption.toUpperCase())
                              ? Row(children: [
                                  Container(
                                    width: 100,
                                    height: searchBarHeight ?? 60,
                                    decoration: BoxDecoration(
                                      // color: kcMedBeige,
                                      border: Border.all(
                                        width: .5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: CustomButton(
                                      color: Colors.transparent,
                                      onTap: () {
                                        switch (expandedState.filterOption
                                            .toUpperCase()) {
                                          case 'TAGS':
                                            if (expandedState
                                                    .filterStrings.length >
                                                1) {
                                              expandedState.filterStrings[0] =
                                                  '';
                                            } else if (expandedState
                                                .filterStrings.isEmpty) {
                                              expandedState.filterStrings = [
                                                ''
                                              ];
                                            }
                                            if (expandedState.filterStrings
                                                .contains(teController.text)) {
                                              showAlreadyInsertedPopUp(
                                                  context, teController);
                                              return;
                                            }
                                            expandedState.addFilterString(
                                                teController.text);
                                            teController.clear();
                                            loginProvider.setDisplayedRecipes(
                                              filteringStrings:
                                                  expandedState.filterStrings,
                                              filterOption:
                                                  expandedState.filterOption,
                                            );
                                            break;
                                          case 'INGREDIENTS':
                                            if (expandedState
                                                    .filterStrings.length >
                                                1) {
                                              expandedState.filterStrings[0] =
                                                  '';
                                            } else if (expandedState
                                                .filterStrings.isEmpty) {
                                              expandedState.filterStrings = [
                                                ''
                                              ];
                                            }
                                            if (expandedState.filterStrings
                                                .contains(teController.text)) {
                                              showAlreadyInsertedPopUp(
                                                  context, teController);
                                              return;
                                            }

                                            expandedState.addFilterString(
                                                teController.text);
                                            loginProvider.setDisplayedRecipes(
                                              filteringStrings:
                                                  expandedState.filterStrings,
                                              filterOption:
                                                  expandedState.filterOption,
                                            );
                                            teController.clear();
                                            break;
                                        }
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: searchBarHeight ?? 60,
                                    margin: const EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: .5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: CustomButton(
                                      color: Colors.transparent,
                                      onTap: () {
                                        expandedState.filterStrings = [];
                                        loginProvider.setDisplayedRecipes(
                                          filteringStrings:
                                              expandedState.filterStrings,
                                          filterOption:
                                              expandedState.filterOption,
                                        );
                                      },
                                      child: const Text('Clear'),
                                    ),
                                  )
                                ])
                              : const SizedBox(),
                        ],
                      ),
                    )
                  : const SizedBox(),
              NavBarItemBackground(
                width: 80,
                height: 70,
                child: loginProvider.userData != null
                    ? ProfilePic(
                        member: Member(
                          name: loginProvider.userData!['username'],
                          email: loginProvider.userData!['email'],
                          password: loginProvider.userData!['password'],
                          profilePicture: loginProvider.userData!['profilePic'],
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

  Future<dynamic> showAlreadyInsertedPopUp(
      BuildContext context, TextEditingController teController) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: .5),
          ),
          child: Container(
            color: kcLightBeige,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: 'You have already added\n\t\t',
                        style: ksTitleButtonStyle),
                    TextSpan(
                        text: teController.text, style: ksFormHeadlineStyle),
                  ],
                ),
              ),
            ),
          ),
        ),
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
