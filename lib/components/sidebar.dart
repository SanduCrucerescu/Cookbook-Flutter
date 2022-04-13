part of components;

class SideBar extends ConsumerWidget {
  final List<Map<String, dynamic>> items;
  final EdgeInsets? margin, padding;
  final double? height, width;

  SideBar({
    required this.items,
    this.margin,
    this.padding,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final sideBarCangeNotifier = ChangeNotifierProvider<SideBarChangeNotifier>(
    (ref) => SideBarChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(sideBarCangeNotifier);

    return Container(
      padding: padding ?? const EdgeInsets.all(10),
      margin: margin ?? const EdgeInsets.only(top: 100),
      height: height ?? size.height - 100,
      width: width ?? state.width,
      decoration: const BoxDecoration(
        border: Border(
          right:
              BorderSide(width: .5, color: kcMedGrey, style: BorderStyle.solid),
        ),
        color: kcMedBeige,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Column(
              children: List.generate(
                items.length,
                (idx) {
                  Widget mainTopic = SideBarItem(
                    collapsed: state.collapsed,
                    prefixImage: Image.asset(
                      items[idx]["image"],
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(items[idx]["onTap"]);
                    },
                    text: items[idx]["text"],
                  );

                  if (items[idx]["children"].length == 0) {
                    return mainTopic;
                  }

                  List<Map<String, dynamic>> subtopics = items[idx]["children"];

                  return Column(
                    children: List.generate(
                      subtopics.length,
                      (idx2) => SideBarItem(
                          text: subtopics[idx2]["text"],
                          onTap: () => Navigator.of(context).pushNamed(
                                subtopics[idx2]["onTap"],
                              ),
                          collapsed: state.collapsed),
                    ),
                  );
                },
              ),
            ),
          ),
          const Expanded(
            flex: 10,
            child: SizedBox(),
          ),
          Expanded(
            flex: 1,
            child: SideBarItem(
              collapsed: state.collapsed,
              prefixImage: state.collapsed
                  ? Image.asset("assets/images/expand.png",
                      fit: BoxFit.fill, height: 15)
                  : Image.asset("assets/images/collapse.png",
                      fit: BoxFit.fill, height: 15),
              text: "C o l l a p s e",
              onTap: () {
                state.collapsed = !state.collapsed;
                if (state.width == 50) {
                  state.width = 200;
                } else {
                  state.width = 50;
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SideBarItem(
              prefixImage: Image.asset("assets/images/lock_open.png",
                  fit: BoxFit.fill, height: 15),
              collapsed: state.collapsed,
              text: "L o g o u t",
              onTap: () {
                Navigator.of(context).pushNamed(LoginPage.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SideBarItem extends ConsumerWidget {
  final bool collapsed;
  final Duration duration;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onTap;
  final double height;
  final double width;
  final Color? color, textColor;
  final Color? accentColor;
  final bool shadow;
  final double margin;
  final EdgeInsets padding;
  final Icon? prefixIcon;
  final Image? prefixImage;
  final BorderRadius? borderRadius;

  SideBarItem({
    required this.text,
    required this.onTap,
    required this.collapsed,
    this.fontSize = 14,
    this.fontWeight = FontWeight.bold,
    this.height = 30,
    this.width = 200,
    this.color,
    this.textColor = kcLightBeige,
    this.duration = const Duration(milliseconds: 0),
    this.accentColor,
    this.shadow = true,
    this.margin = 10,
    this.padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
    this.borderRadius,
    this.prefixIcon,
    this.prefixImage,
    Key? key,
  }) : super(key: key);

  final _hoveringNotifier = ChangeNotifierProvider<SideBarItemChangeNotifier>(
    (ref) => SideBarItemChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_hoveringNotifier);

    return AnimatedContainer(
      duration: duration,
      margin: EdgeInsets.only(bottom: margin),
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          color: state.backgroundColor,
          borderRadius: BorderRadius.circular(3) // borderRadius,
          ),
      child: InkWell(
        onTap: onTap,
        onHover: (val) => state.onHover(val),
        child: Stack(children: [
          Positioned(
            left: 7,
            top: 2,
            child: collapsed
                ? const SizedBox()
                : prefixImage ?? prefixIcon ?? const SizedBox(),
          ),
          Center(
            child: collapsed
                ? prefixImage ??
                    prefixIcon ??
                    Text(
                      text[0],
                      style: GoogleFonts.montserrat(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: state.textColor,
                      ),
                    )
                : Text(
                    text,
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: state.textColor,
                    ),
                  ),
          ),
        ]),
      ),
    );
  }
}

class SideBarItemChangeNotifier extends ChangeNotifier {
  bool _hovering = false;
  bool _expanded = false;
  Color _backgroundColor = kcLightBeige;
  Color _textColor = kcDarkGreen.withOpacity(.9);

  bool get hovering => _hovering;
  bool get expanded => _expanded;
  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;

  set hovering(bool val) {
    _hovering = val;
    notifyListeners();
  }

  set expanded(bool val) {
    _expanded = val;
    notifyListeners();
  }

  set backgroundColor(Color newBackgroundColor) {
    _backgroundColor = newBackgroundColor;
    notifyListeners();
  }

  set textColor(Color newTextColor) {
    _textColor = newTextColor;
    notifyListeners();
  }

  void onHover(bool val) {
    hovering = val;
    backgroundColor = val ? Colors.white : kcLightBeige;
    notifyListeners();
  }
}

class SideBarChangeNotifier extends ChangeNotifier {
  bool _collapsed = false;
  double _width = 200;

  bool get collapsed => _collapsed;
  double get width => _width;

  set collapsed(bool val) {
    _collapsed = val;
    notifyListeners();
  }

  set width(double val) {
    _width = val;
    notifyListeners();
  }
}
