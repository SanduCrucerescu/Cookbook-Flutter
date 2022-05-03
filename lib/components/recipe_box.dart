part of components;

class RecipeBox extends ConsumerWidget {
  final Image? profilePicture, image;
  final Recipe recipe;

  static const double horiLineIndent = 10;
  static const double actionRowIndent = 20;
  static const double descriptonRowIndent = 45;

  RecipeBox({
    required this.recipe,
    this.image,
    this.profilePicture,
    Key? key,
  }) : super(key: key);

  final hoveringProvider = ChangeNotifierProvider<RecipeBoxIconHoverNotifier>(
    (ref) => RecipeBoxIconHoverNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hoveringProvider);

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
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 100,
            ),
            decoration: BoxDecoration(
              boxShadow: !state.hovering
                  ? [
                      const BoxShadow(
                        spreadRadius: .5,
                        blurRadius: 15,
                        color: Color(0xFF606060),
                        offset: Offset(10, 12),
                      )
                    ]
                  : null,
            ),
            child: RecipeBoxIcon(
              onHover: () {
                state.hovering = !state.hovering;
              },
              child: state.hovering
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      width: 420,
                      height: 420,
                      color: kcLightBeige,
                      child: Center(
                        child: Text(
                          recipe.shortDescription,
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
              // imagePath: image != null ? null : "assets/images/food.png",
              width: 420,
              height: 420,
              isImage: true,
            ),
          ),
        ),
        const Positioned(left: horiLineIndent, top: 510, child: HoriLine()),
        Positioned(
          top: 534,
          left: actionRowIndent,
          child: RecipeActionsRow(
            recipe: recipe,
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

class RecipeActionsRow extends ConsumerWidget {
  final Recipe recipe;
  RecipeActionsRow({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  final favoritesProvider = ChangeNotifierProvider<VerificationNotifier>(
      ((ref) => VerificationNotifier()));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoritesProvider);

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
                      color: Colors.red),
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
              state.isTaped
                  ? RecipeBoxIcon(
                      icon: Icon(Icons.star_outlined),
                      color: Colors.black,
                      height: 33,
                      width: 33,
                      onTap: () {
                        state.isTaped = false;
                        Favorites.delete(
                            email: InheritedLoginProvider.of(context)
                                .userData?['email'],
                            recipeID: recipe.id);
                      },
                    )
                  : RecipeBoxIcon(
                      icon: Icon(Icons.star_outline),
                      color: Colors.black,
                      height: 33,
                      width: 33,
                      onTap: () async {
                        bool val = await Favorites.adding(
                            email: InheritedLoginProvider.of(context)
                                .userData?['email'],
                            recipeID: recipe.id);
                        if (!val) {
                          state.exists = true;
                          state.text = "Recipe already inserted";
                        } else {
                          state.isTaped = true;
                        }
                      },
                    ),
              const RecipeBoxIcon(
                icon: Icon(Icons.mode_comment_outlined),
                height: 25,
                width: 25,
                color: Colors.black,
              ),
              const RecipeBoxIcon(
                icon: Icon(Icons.share),
                height: 30,
                width: 30,
                color: Colors.black,
              ),
            ],
          ),
        ),
        trailing: const RecipeBoxIcon(
          icon: const Icon(Icons.share),
          height: 30,
          width: 30,
          color: Colors.black,
        ));
  }
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
  bool _isTaped = false;
  bool _exists = false;
  String _text = "";

  bool get isTaped => _isTaped;

  bool get exists => _exists;

  String get text => _text;

  set isTaped(bool val) {
    _isTaped = val;
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
}
