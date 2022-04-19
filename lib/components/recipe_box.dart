part of components;

class RecipeBox extends StatelessWidget {
  final String? id, title, shortDescription, longDescription, creatorEmail;
  final double? quantity;
  final List<String>? tags;
  final Image? profilePicture, image;

  static const double horiLineIndent = 10;
  static const double actionRowIndent = 20;
  static const double descriptonRowIndent = 45;

  const RecipeBox({
    this.id,
    this.title,
    this.shortDescription,
    this.longDescription,
    this.quantity,
    this.creatorEmail,
    this.tags,
    this.profilePicture,
    this.image,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          child: RecipeBoxTopRow(profilePicture: profilePicture),
        ),
        const Positioned(left: horiLineIndent, top: 70, child: HoriLine()),
        Positioned(
          top: 90,
          left: 15,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: .5,
                  blurRadius: 15,
                  color: Color(0xFF606060),
                  offset: Offset(10, 12),
                )
              ],
            ),
            child: RecipeBoxIcon(
              image: image,
              imagePath: image != null ? null : "assets/images/food.png",
              width: 420,
              height: 420,
              isImage: true,
            ),
          ),
        ),
        const Positioned(left: horiLineIndent, top: 510, child: HoriLine()),
        const Positioned(
          top: 534,
          left: actionRowIndent,
          child: RecipeActionsRow(),
        ),
        const Positioned(left: horiLineIndent, top: 570, child: HoriLine()),
        const Positioned(
          left: descriptonRowIndent,
          top: 590,
          child: RecipeInformationRow(
            text: 'tags',
            children: [
              RecipeTag(text: 'Vegan'),
              RecipeTag(text: 'Vegeterian'),
              RecipeTag(text: 'Bio'),
              RecipeTag(text: 'Natural'),
              RecipeTag(text: 'Öko'),
              RecipeTag(text: 'Nachhaltig'),
            ],
          ),
        ),
        const Positioned(
          left: descriptonRowIndent,
          top: 615,
          child: RecipeInformationRow(
            text: 'stars',
            children: [Text('34')],
          ),
        ),
      ]),
    );
  }
}

class RecipeBoxTopRow extends StatelessWidget {
  const RecipeBoxTopRow({
    Key? key,
    required this.profilePicture,
  }) : super(key: key);

  final Image? profilePicture;

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
      title: const SelectableText(
        "Kenobi",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
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

class RecipeActionsRow extends StatelessWidget {
  const RecipeActionsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeBoxRow(
      height: 30,
      width: 400,
      leading: SizedBox(
        height: 20,
        width: 180,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            RecipeBoxIcon(
              icon: Icon(Icons.star),
              color: Colors.black,
              height: 33,
              width: 33,
            ),
            RecipeBoxIcon(
              icon: Icon(Icons.mode_comment_outlined),
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            RecipeBoxIcon(
              icon: Icon(Icons.share),
              height: 30,
              width: 30,
              color: Colors.black,
            ),
          ],
        ),
      ),
      trailing: const RecipeBoxIcon(
        icon: Icon(Icons.add),
        height: 30,
        width: 30,
        color: Colors.black,
      ),
    );
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
  final String text;
  final TextStyle? textStyle;

  const RecipeTag({
    required this.text,
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
        text,
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

  const RecipeBoxIcon({
    Key? key,
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
        onTap: () {},
        onHover: (val) => onHover == null ? {} : onHover!(),
        child: Row(
          children: [
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
