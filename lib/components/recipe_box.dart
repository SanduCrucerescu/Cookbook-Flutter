part of components;

class RecipeBox extends ConsumerWidget {
  final Image? profilePicture, image;
  final Recipe recipe;
  final bool isLiked;

  static const double horiLineIndent = 10;
  static const double actionRowIndent = 20;
  static const double descriptonRowIndent = 45;

  RecipeBox({
    required this.recipe,
    this.isLiked = true,
    this.image,
    this.profilePicture,
    Key? key,
  }) : super(key: key);

  final hoveringProvider = ChangeNotifierProvider<RecipeBoxIconHoverNotifier>(
    (ref) => RecipeBoxIconHoverNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          width: 450,
          height: 650,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: kcMedGrey,
              width: .6,
              style: BorderStyle.solid,
            ),
          ),
          child: Stack(children: <Widget>[
            Positioned(
              top: 20,
              left: actionRowIndent,
              child: RecipeBoxTopRow(
                profilePicture: Image.asset('assets/images/ph.png'),
                recipe: recipe,
              ),
            ),
            const Positioned(left: horiLineIndent, top: 70, child: HoriLine()),
            Positioned(
              top: 90,
              left: 15,
              child: Consumer(
                builder: (context, ref, child) {
                  final hoveringState = ref.watch(hoveringProvider);
                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 50,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: !hoveringState.hovering
                          ? [
                              const BoxShadow(
                                spreadRadius: .3,
                                blurRadius: 25,
                                color: Color(0xFFAAAAAA),
                                offset: Offset(10, 12),
                              )
                            ]
                          : null,
                    ),
                    child: RecipeBoxIcon(
                      onHover: () {
                        hoveringState.hovering = !hoveringState.hovering;
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipePage(
                              recipe: recipe,
                            ),
                          ),
                        );
                      },
                      image: Image.memory(
                        getImageDataFromBlob(recipe.picture),
                        fit: BoxFit.cover,
                        height: 420,
                        width: 420,
                      ),
                      width: 420,
                      height: 420,
                      isImage: true,
                      child: hoveringState.hovering
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              width: 420,
                              height: 420,
                              // color: kcLightBeige,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: .5,
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                color: kcLightBeige,
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          recipe.title,
                                          style: ksFormHeadlineStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          recipe.shortDescription,
                                          style: ksTitleButtonStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
            const Positioned(left: horiLineIndent, top: 510, child: HoriLine()),
            Positioned(
              top: 534,
              left: actionRowIndent,
              child: RecipeActionsRow(recipe: recipe, isLiked: isLiked),
            ),
            const Positioned(left: horiLineIndent, top: 570, child: HoriLine()),
            Positioned(
              left: descriptonRowIndent,
              top: 590,
              child: RecipeInformationRow(text: 'tags', children: [
                ...recipe.tags.map(
                  (tag) => RecipeBoxInformationOval(tag: tag),
                ),
              ]),
            ),
            Positioned(
              left: descriptonRowIndent,
              top: 615,
              child: RecipeInformationRow(text: 'ingredients', children: [
                ...recipe.ingredients.map(
                  (ingredient) =>
                      RecipeBoxInformationOval(ingredient: ingredient),
                ),
              ]),
            ),
          ]),
        );
      },
    );
  }
}

class RecipeBoxTopRow extends ConsumerWidget {
  final Recipe recipe;
  final Image? profilePicture;

  const RecipeBoxTopRow({
    Key? key,
    required this.recipe,
    required this.profilePicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersState = ref.watch(membersProvider);
    final member =
        recipe.ownerEmail == InheritedLoginProvider.of(context).member!.email
            ? InheritedLoginProvider.of(context).member
            : membersState.members.isNotEmpty
                ? membersState.members[membersState.members
                    .map((e) => e.email)
                    .toList()
                    .indexOf(recipe.ownerEmail)]
                : null;
    return RecipeBoxRow(
      width: 400,
      leading: SizedBox(
        width: 80,
        child: Center(
          child: ProfilePic(
            height: 40,
            width: 40,
            member: member,
          ),
        ),
      ),
      title: Column(
        children: [
          SelectableText(
            recipe.title.length > 20
                ? '${recipe.title.substring(0, 20)}...'
                : recipe.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SelectableText(
            'by ${member != null ? member.name : ''}',
          ),
        ],
      ),
      trailing: SizedBox(
        child: Row(
          children: const [
            RecipeBoxIcon(
              icon: Icon(
                Icons.menu,
              ),
              height: 40,
              width: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeActionsRow extends StatefulHookConsumerWidget {
  final Recipe recipe;
  final bool isLiked;
  RecipeActionsRow({
    required this.recipe,
    this.isLiked = false,
    Key? key,
  }) : super(key: key);

  final stateProvider = ChangeNotifierProvider<VerificationNotifier>(
      ((ref) => VerificationNotifier()));

  @override
  _RecipeActionsRow createState() => _RecipeActionsRow();
}

class _RecipeActionsRow extends ConsumerState<RecipeActionsRow> {
  final _membersProvider = ChangeNotifierProvider<MessagePageController>(
    (ref) => MessagePageController(),
  );

  @override
  Widget build(BuildContext context) {
    final membersState = ref.watch(membersProvider);
    final state = ref.watch(widget.stateProvider);
    final searchTec = useTextEditingController();
    final commentTec = useTextEditingController();
    final loginProvider = InheritedLoginProvider.of(context);

    return Builder(
      builder: ((context) {
        bool isLiked = InheritedLoginProvider.of(context)
            .favorites
            .map((e) => e.ownerEmail)
            .contains(widget.recipe.ownerEmail);

        return RecipeBoxRow(
          height: 30,
          width: 400,
          title: state.exists
              ? Center(
                  child: SelectableText(
                    state.text,
                    style: GoogleFonts.montserrat(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                )
              : const SizedBox(),
          leading: SizedBox(
            height: 20,
            width: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                isLiked
                    ? RecipeBoxIcon(
                        icon: const Icon(Icons.star_outlined),
                        color: Colors.black,
                        height: 33,
                        width: 33,
                        onTap: () async {
                          await Favorites.delete(
                              email: InheritedLoginProvider.of(context)
                                  .userData?['email'],
                              recipeID: widget.recipe.id);
                          loginProvider.favorites = await GetFavorites()
                                  .getfav(loginProvider.userData!['email']) ??
                              [];
                        },
                      )
                    : RecipeBoxIcon(
                        icon: const Icon(Icons.star_outline),
                        color: Colors.black,
                        height: 33,
                        width: 33,
                        onTap: () async {
                          bool val = await Favorites.adding(
                              email: loginProvider.userData?['email'],
                              recipeID: widget.recipe.id);
                          if (!val) {
                            state.exists = true;
                            state.text = "Recipe already inserted";
                          }
                          loginProvider.favorites = await GetFavorites()
                                  .getfav(loginProvider.userData!['email']) ??
                              [];
                        },
                      ),
                RecipeBoxIcon(
                  icon: const Icon(Icons.mode_comment_outlined),
                  height: 25,
                  width: 25,
                  color: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsPage(
                          recipe: widget.recipe,
                        ),
                      ),
                    );
                  },
                ),
                RecipeBoxIcon(
                  icon: const Icon(Icons.share),
                  height: 30,
                  width: 30,
                  color: Colors.black,
                  onTap: () async {
                    membersState.members = await getMembers(
                      context,
                      // loginProvider.member!.email,
                    );
                    membersState.advancedSetDisplayedMembers(
                      membersState.members,
                      context,
                    );
                    shareRecipe(
                      context,
                      searchTec,
                      commentTec,
                      membersState,
                    );
                  },
                ),
              ],
            ),
          ),
          trailing: RecipeBoxIcon(
            onTap: () {
              addWeekly(context, state, widget.recipe);
            },
            icon: const Icon(Icons.add),
            height: 30,
            width: 30,
            color: Colors.black,
          ),
        );
      }),
    );
  }

  Future<dynamic> shareRecipe(
    BuildContext context,
    TextEditingController searchTec,
    TextEditingController commentTec,
    MessagePageController state,
  ) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kcMedBeige,
          title: const Center(child: Text("Share Recipe")),
          content: Container(
            height: size.height - 200,
            width: (size.width - 100) / 2,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onChanged: (value) {
                    state.displayedMembers = [];
                    state.filteringString = value;
                    for (Member member in state.members) {
                      if (member.name
                          .toUpperCase()
                          .startsWith(state.filteringString.toUpperCase())) {
                        state.addDisplayedMember(member);
                      }
                    }
                  },
                  onClickSuffix: () {
                    searchTec.clear();
                    state.filteringString = '';
                  },
                  controller: searchTec,
                  margin: const EdgeInsets.only(bottom: 20),
                  backgroundColor: kcLightBeige,
                  border: Border.all(color: Colors.black),
                  height: 50,
                  hintText: 'Search Recipient...',
                ),
                const SizedBox(
                  height: 20,
                ),
                const ShareListview(),
                CustomTextField(
                  onChanged: (comment) {
                    state.message = comment;
                  },
                  onClickSuffix: () {
                    commentTec.clear();
                    state.message = '';
                  },
                  controller: commentTec,
                  backgroundColor: kcLightBeige,
                  border: Border.all(color: Colors.black),
                  margin: const EdgeInsets.only(top: 75),
                  height: 50,
                  hintText: 'Write a comment...',
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                for (int i = 0; i < state.shareMembers.length; i++) {
                  SendMessage.sendMessage(data: {
                    'sender':
                        InheritedLoginProvider.of(context).userData?['email'],
                    'receiver': state.shareMembers[i].email,
                    'content': state.message,
                    'time': DateTime.now().toString(),
                    'recipeID': widget.recipe.id
                  }, isLink: true);
                }
                commentTec.clear();
                state.message = '';
                print(state.shareMembers);
                state.shareMembers.clear();
                print(state.shareMembers);
              },
              child: const Text('Send',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}

Future<dynamic> addWeekly(
    BuildContext context, VerificationNotifier state, Recipe recipe) {
  final List<CustDropdownMenuItem<String>> mealType = [
    const CustDropdownMenuItem(
      value: '1',
      child: Text("Breakfast"),
    ),
    const CustDropdownMenuItem(
      value: '2',
      child: Text("Lunch"),
    ),
    const CustDropdownMenuItem(
      value: '3',
      child: Text("Dinner"),
    ),
  ];

  final List<CustDropdownMenuItem<String>> weekDays = [
    const CustDropdownMenuItem(
      value: '1',
      child: Text("Monday"),
    ),
    const CustDropdownMenuItem(
      value: '2',
      child: Text("Tuesday"),
    ),
    const CustDropdownMenuItem(
      value: '3',
      child: Text("Wednesday"),
    ),
    const CustDropdownMenuItem(
      value: '4',
      child: Text("Thursday"),
    ),
    const CustDropdownMenuItem(
      value: '5',
      child: Text("Friday"),
    ),
    const CustDropdownMenuItem(
      value: '6',
      child: Text("Saturday"),
    ),
    const CustDropdownMenuItem(
      value: '7',
      child: Text("Sunday"),
    ),
  ];
  state.week = weekNumber(DateTime.now());

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add weekly recipe"),
        actions: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                state.notInserted
                    ? Center(
                        child: SelectableText(
                          state.weeklyText,
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      )
                    : const SizedBox(),
                Row(
                  children: [
                    const SelectableText(
                      "Recipe name: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SelectableText(
                      recipe.title,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    const SelectableText(
                      "Week",
                      style: TextStyle(fontSize: 20),
                    ),
                    NumericStepButton(
                      counter: weekNumber(DateTime.now()),
                      onChanged: (val) {
                        state.week = val;
                        print(state.week);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SelectableText(
                      "Day of week:",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 150,
                        child: CustDropDown(
                          items: weekDays,
                          onChanged: (val) {
                            state.weekDay = val;
                          },
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SelectableText(
                      "Meal Type:",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 150,
                        child: CustDropDown(
                          items: mealType,
                          onChanged: (val) {
                            state.mealType = val;
                          },
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  duration: const Duration(milliseconds: 200),
                  onTap: () async {
                    if (state.weekDay == null || state.mealType == null) {
                      state.notInserted = true;
                      state.weeklyText = "Please fill all the fields;";
                    } else {
                      AddWeaklys.addWeaklys(data: {
                        "email": InheritedLoginProvider.of(context)
                            .userData?['email'],
                        "week": state.week,
                        "day": state.weekDay,
                        "meal_type": state.mealType,
                        "recipe_id": recipe.id,
                      });
                      Navigator.pop(context);
                      state.weekDay = "";
                      state.mealType = "";
                    }
                  },
                  width: 150,
                  height: 50,
                  child: const Text("Add Recipe"),
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

class RecipeInformationRow extends StatelessWidget {
  final List<Widget> children;
  final String text;

  const RecipeInformationRow({
    required this.text,
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeBoxRow(
      titleLeftOffset: const EdgeInsets.only(left: 20),
      height: 20,
      leading: SizedBox(
        child: SelectableText(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: SizedBox(
        width: 350,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: children,
        ),
      ),
    );
  }
}

class RecipeBoxInformationOval extends StatelessWidget {
  final EdgeInsets? margin, padding;
  final BorderRadius? borderRadius;
  final Color? bgColor, textColor;
  final Border? border;
  final Tag? tag;
  final Ingredient? ingredient;
  final TextStyle? textStyle;

  const RecipeBoxInformationOval({
    this.tag,
    this.ingredient,
    this.margin,
    this.padding,
    this.borderRadius,
    this.bgColor,
    this.textColor,
    this.border,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(right: 2),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        border: border ??
            Border.all(
              color: kcMedGrey,
              width: 1.0,
              style: BorderStyle.solid,
            ),
      ),
      child: SelectableText(
        tag != null
            ? tag!.name
            : ingredient != null
                ? ingredient!.name
                : '',
        style: textStyle ??
            const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
      ),
    );
  }
}

class RecipeBoxRow extends StatelessWidget {
  final Widget? leading, trailing, title, subtitle;
  final EdgeInsets? padding, titleLeftOffset;
  final double? width, height;

  const RecipeBoxRow({
    Key? key,
    this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.padding,
    this.width,
    this.height,
    this.titleLeftOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: height,
                child: leading,
              ),
              Container(
                height: height,
                padding: const EdgeInsets.all(0),
                margin: titleLeftOffset ?? const EdgeInsets.all(0),
                child: title,
              ),
            ],
          ),
          SizedBox(
            height: height ?? 30,
            width: height ?? 30,
            child: trailing,
          )
        ],
      ),
    );
  }
}

class RecipeBoxIcon extends StatelessWidget {
  final double? width, height;
  final String? imagePath;
  final Image? image;
  final EdgeInsets? padding, margin;
  final Color? color, bgColor;
  final VoidCallback? onTap, onHover;
  final bool isImage;
  final Icon? icon;
  final Widget? child;

  const RecipeBoxIcon({
    Key? key,
    this.child,
    this.imagePath,
    this.width = 30,
    this.height = 30,
    this.padding,
    this.margin,
    this.color,
    this.bgColor,
    this.onTap,
    this.onHover,
    this.icon,
    this.isImage = false,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding ?? const EdgeInsets.all(0),
      margin: margin ?? const EdgeInsets.all(0),
      // color: color,
      child: InkWell(
        onTap: onTap == null ? () {} : () => onTap!(),
        onHover: (val) => onHover == null ? {} : onHover!(),
        child: Row(
          children: child != null
              ? [child!]
              : [
                  image != null
                      ? image!
                      : icon != null
                          ? SizedBox(
                              height: height,
                              width: width,
                              child: icon,
                            )
                          : (imagePath != null
                              ? Image.asset(
                                  imagePath!,
                                  fit: BoxFit.fill,
                                  height: 500,
                                  width: width,
                                  color: isImage ? null : color ?? kcMedGrey,
                                )
                              : const SizedBox()),
                ],
        ),
      ),
    );
  }
}

class HoriLine extends StatelessWidget {
  final double? length;
  final double? width;
  final EdgeInsets? paddingHorizontal, margin;

  const HoriLine({
    this.paddingHorizontal,
    this.margin,
    this.length,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingHorizontal ?? const EdgeInsets.symmetric(horizontal: 0),
      margin: margin ?? const EdgeInsets.all(10),
      height: width ?? .7,
      width: length ?? 410,
      color: kcMedGrey,
    );
  }
}

class RecipeBoxIconHoverNotifier extends ChangeNotifier {
  bool _hovering = false;

  bool get hovering => _hovering;

  set hovering(bool val) {
    _hovering = val;
    notifyListeners();
  }
}

class VerificationNotifier extends ChangeNotifier {
  int _week = 1;
  String _weekDay = "";
  String _mealType = "";
  bool _isTapped = false;
  bool _exists = false;
  String _text = "";
  bool _notInserted = false;
  String _weeklyText = "";

  String get weeklyText => _weeklyText;

  bool get isLiked => _isTapped;

  bool get exists => _exists;

  String get text => _text;

  int get week => _week;

  String get weekDay => _weekDay;

  String get mealType => _mealType;

  bool get notInserted => _notInserted;

  set isLiked(bool val) {
    _isTapped = val;
    notifyListeners();
  }

  set exists(bool val) {
    _exists = val;
    notifyListeners();
  }

  set text(String text) {
    _text = text;
    notifyListeners();
  }

  set week(int val) {
    _week = val;
    notifyListeners();
  }

  set weekDay(String value) {
    _weekDay = value;
    notifyListeners();
  }

  set mealType(value) {
    _mealType = value;
    notifyListeners();
  }

  set weeklyText(String value) {
    _weeklyText = value;
    notifyListeners();
  }

  set notInserted(value) {
    _notInserted = value;
    notifyListeners();
  }
}
