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
    this.isLiked = false,
    this.image,
    this.profilePicture,
    Key? key,
  }) : super(key: key);

  final hoveringProvider = ChangeNotifierProvider<RecipeBoxIconHoverNotifier>(
    (ref) => RecipeBoxIconHoverNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 450,
      height: 650,
      decoration: BoxDecoration(
        color: Colors.white,
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
              final _state = ref.watch(hoveringProvider);
              return AnimatedContainer(
                duration: const Duration(
                  milliseconds: 50,
                ),
                decoration: BoxDecoration(
                  boxShadow: !_state.hovering
                      ? [
                          const BoxShadow(
                            spreadRadius: .5,
                            blurRadius: 15,
                            color: Color(0xFFAAAAAA),
                            offset: Offset(10, 12),
                          )
                        ]
                      : null,
                ),
                child: RecipeBoxIcon(
                  onHover: () {
                    _state.hovering = !_state.hovering;
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
                  child: _state.hovering
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
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            color: kcLightBeige,
                            child: Center(
                              child: SingleChildScrollView(
                                child: Text(
                                  recipe.shortDescription,
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                  image: Image.memory(
                    getImageDataFromBlob(recipe.picture),
                    fit: BoxFit.cover,
                    height: 420,
                    width: 420,
                  ),
                  width: 420,
                  height: 420,
                  isImage: true,
                ),
              );
            },
          ),
        ),
        const Positioned(left: horiLineIndent, top: 510, child: HoriLine()),
        Positioned(
          top: 534,
          left: actionRowIndent,
          child: RecipeActionsRow(
            recipe: recipe,
            isLiked: isLiked,
          ),
        ),
        const Positioned(left: horiLineIndent, top: 570, child: HoriLine()),
        Positioned(
          left: descriptonRowIndent,
          top: 590,
          child: RecipeInformationRow(text: 'tags', children: [
            ...recipe.tags.map(
              (tag) => RecipeTag(tag: tag),
            ),
          ]),
        ),
        Positioned(
          left: descriptonRowIndent,
          top: 615,
          child: RecipeInformationRow(
            text: 'id, we dont have stars currently',
            children: [Text(recipe.id.toString())],
          ),
        ),
      ]),
    );
  }
}

class RecipeBoxTopRow extends StatelessWidget {
  final Recipe recipe;
  final Image? profilePicture;

  const RecipeBoxTopRow({
    Key? key,
    required this.recipe,
    required this.profilePicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeBoxRow(
      width: 400,
      leading: SizedBox(
        width: 80,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: profilePicture ??
                    Image.asset(
                      "assets/images/hellothere.png",
                      fit: BoxFit.cover,
                      height: 55,
                      width: 55,
                    ),
              ),
            ),
          ],
        ),
      ),
      title: Column(
        children: [
          SelectableText(
            recipe.title.length > 20
                ? recipe.title.substring(0, 20) + '...'
                : recipe.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SelectableText(
            'by ' + recipe.ownerEmail,
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
  const RecipeActionsRow({
    required this.recipe,
    this.isLiked = false,
    Key? key,
  }) : super(key: key);

<<<<<<< HEAD
<<<<<<< HEAD
=======
  final stateProvider = ChangeNotifierProvider<VerificationNotifier>(
    ((ref) => VerificationNotifier()),
  );

>>>>>>> a9cc257 (commi)
=======
>>>>>>> 85ac6f9 (commi)
  @override
  _RecipeActionsRow createState() => _RecipeActionsRow();
}

class _RecipeActionsRow extends ConsumerState<RecipeActionsRow> {
  final stateProvider = ChangeNotifierProvider<VerificationNotifier>(
    ((ref) => VerificationNotifier()),
  );

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
<<<<<<< HEAD
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      ref.read(stateProvider).isLiked = widget.isLiked;
      final membersState = ref.read(membersProvider);
      membersState.members = await getMembers(context);
      membersState.advancedSetDisplayedMembers(membersState.members, context);
=======
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      ref.read(widget.stateProvider).isLiked = widget.isLiked;
      final membersState = ref.read(membersProvider);
      membersState.members = await getMembers(context);
      membersState.advancedSetDisplayedMembers(membersState.members, context);
      setState(() {});
>>>>>>> 0cb3fb2 (continue share function)
=======
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      ref.read(stateProvider).isLiked = widget.isLiked;
      final membersState = ref.read(membersProvider);
      membersState.members = await getMembers(context);
      membersState.advancedSetDisplayedMembers(membersState.members, context);
>>>>>>> 85ac6f9 (commi)
    });
  }

  @override
  Widget build(BuildContext context) {
    final membersState = ref.watch(membersProvider);
<<<<<<< HEAD
<<<<<<< HEAD
    final state = ref.watch(stateProvider);
=======
    final state = ref.watch(widget.stateProvider);
>>>>>>> 0cb3fb2 (continue share function)
=======
    final state = ref.watch(stateProvider);
>>>>>>> 85ac6f9 (commi)
    final searchTec = useTextEditingController();
    final commentTec = useTextEditingController();

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
            state.isLiked
                ? RecipeBoxIcon(
                    icon: const Icon(Icons.star_outlined),
                    color: Colors.black,
                    height: 33,
                    width: 33,
                    onTap: () {
                      Favorites.delete(
                        email: InheritedLoginProvider.of(context)
                            .userData?['email'],
                        recipeID: widget.recipe.id,
                      );
                      state.isLiked = false;
                    },
                  )
                : RecipeBoxIcon(
                    icon: const Icon(Icons.star_outline),
                    color: Colors.black,
                    height: 33,
                    width: 33,
                    onTap: () async {
                      bool val = await Favorites.adding(
                        email: InheritedLoginProvider.of(context)
                            .userData?['email'],
                        recipeID: widget.recipe.id,
                      );
                      if (!val) {
                        state.exists = true;
                        state.text = "Recipe already inserted";
                      } else {
                        state.isLiked = true;
                      }
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
              onTap: () {
                areyousure2(context, searchTec, commentTec, membersState);
              },
            ),
          ],
        ),
      ),
      trailing: RecipeBoxIcon(
        onTap: () {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
          // addWeekly(context);
=======
          addWeekly(context, state, widget.recipe);
>>>>>>> ce0b8c1 (Finished the alert dialog to insert recipes into weeklys)
=======
=======
>>>>>>> 1c80980 (commi)
          addWeekly(context, state, widget.recipe);
=======
          // addWeekly(context);
>>>>>>> 249ea74 (Semi fixed bug with unintended refreshes)
<<<<<<< HEAD
>>>>>>> 85ac6f9 (commi)
=======
=======
          // addWeekly(context);
=======
          addWeekly(context, state, widget.recipe);
>>>>>>> ce0b8c1 (Finished the alert dialog to insert recipes into weeklys)
>>>>>>> 2d12c16 (commit)
>>>>>>> 1c80980 (commi)
        },
        icon: const Icon(Icons.add),
        height: 30,
        width: 30,
        color: Colors.black,
      ),
    );
  }

  Future<dynamic> areyousure2(
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
<<<<<<< HEAD
<<<<<<< HEAD
          content: SizedBox(
=======
          content: Container(
>>>>>>> 0cb3fb2 (continue share function)
=======
          content: SizedBox(
>>>>>>> 85ac6f9 (commi)
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
                    'time': DateTime.now().toString()
                  });
                }
                commentTec.clear();
                state.message = '';
<<<<<<< HEAD
<<<<<<< HEAD
                state.shareMembers.clear();
=======
                print(state.shareMembers);
                state.shareMembers.clear();
                print(state.shareMembers);
>>>>>>> 0cb3fb2 (continue share function)
=======
                state.shareMembers.clear();
>>>>>>> 85ac6f9 (commi)
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

int weekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat("D").format(date));
  return ((dayOfYear - date.weekday + 10) / 7).floor();
}

Future<dynamic> addWeekly(
    BuildContext context, VerificationNotifier state, Recipe recipe) {
  final List<CustDropdownMenuItem<String>> mealType = [
    const CustDropdownMenuItem(
      child: Text("Breakfast"),
      value: 'Breakfast',
    ),
    const CustDropdownMenuItem(
      child: Text("Lunch"),
      value: 'Lunch',
    ),
    const CustDropdownMenuItem(
      child: Text("Dinner"),
      value: 'Dinner',
    ),
  ];

  final List<CustDropdownMenuItem<String>> weekDays = [
    const CustDropdownMenuItem(
      child: Text("Monday"),
      value: 'Monday',
    ),
    const CustDropdownMenuItem(
      child: Text("Tuesday"),
      value: 'Tuesday',
    ),
    const CustDropdownMenuItem(
      child: Text("Wednesday"),
      value: 'Wednesday',
    ),
    const CustDropdownMenuItem(
      child: Text("Thursday"),
      value: 'Thursday',
    ),
    const CustDropdownMenuItem(
      child: Text("Friday"),
      value: 'Friday',
    ),
    const CustDropdownMenuItem(
      child: Text("Saturday"),
      value: 'Saturday',
    ),
    const CustDropdownMenuItem(
      child: Text("Sunday"),
      value: 'Sunday',
    ),
  ];
  return showDialog(
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add weekly recipe"),
        actions: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SelectableText(
                      "Week",
                      style: TextStyle(fontSize: 20),
                    ),
                    NumericStepButton(
                      counter: weekNumber(DateTime.now()),
                      onChanged: (val) {},
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
                    SizedBox(
                      width: 150,
                      child: CustDropDown(
                        items: weekDays,
                        onChanged: (val) {},
                      ),
                    ),
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
                    SizedBox(
                      width: 150,
                      child: CustDropDown(
                        items: mealType,
                        onChanged: (val) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  duration: const Duration(milliseconds: 200),
                  onTap: () {},
                  child: const Text("Add Recipe"),
                  width: 150,
                  height: 50,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
=======
=======
>>>>>>> 85ac6f9 (commi)
=======
>>>>>>> 1c80980 (commi)
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
                      state.week = weekNumber(DateTime.now());
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
                      }
                    },
                    child: const Text("Add Recipe"),
                    width: 150,
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        );
      });
<<<<<<< HEAD
>>>>>>> ce0b8c1 (Finished the alert dialog to insert recipes into weeklys)
=======
=======
=======
>>>>>>> 2d12c16 (commit)
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add weekly recipe"),
        actions: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SelectableText(
                      "Week",
                      style: TextStyle(fontSize: 20),
                    ),
                    NumericStepButton(
                      counter: weekNumber(DateTime.now()),
                      onChanged: (val) {},
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
                    SizedBox(
                      width: 150,
                      child: CustDropDown(
                        items: weekDays,
                        onChanged: (val) {},
                      ),
                    ),
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
                    SizedBox(
                      width: 150,
                      child: CustDropDown(
                        items: mealType,
                        onChanged: (val) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  duration: const Duration(milliseconds: 200),
                  onTap: () {},
                  child: const Text("Add Recipe"),
                  width: 150,
                  height: 50,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
<<<<<<< HEAD
>>>>>>> 249ea74 (Semi fixed bug with unintended refreshes)
<<<<<<< HEAD
>>>>>>> 85ac6f9 (commi)
=======
=======
=======
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
                      state.week = weekNumber(DateTime.now());
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
                      }
                    },
                    child: const Text("Add Recipe"),
                    width: 150,
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        );
      });
>>>>>>> ce0b8c1 (Finished the alert dialog to insert recipes into weeklys)
>>>>>>> 2d12c16 (commit)
>>>>>>> 1c80980 (commi)
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

class RecipeTag extends StatelessWidget {
  final EdgeInsets? margin, padding;
  final BorderRadius? borderRadius;
  final Color? bgColor, textColor;
  final Border? border;
  final Tag tag;
  final TextStyle? textStyle;

  const RecipeTag({
    required this.tag,
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
        tag.name,
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

  set weekDay(String value) => _weekDay = value;

  set mealType(value) => _mealType = value;

  set weeklyText(String value) => _weeklyText = value;

  set notInserted(value) => _notInserted = value;
}
