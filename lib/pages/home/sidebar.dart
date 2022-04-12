import 'package:cookbook/pages/login/login.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SideBar extends ConsumerWidget {
  SideBar({Key? key}) : super(key: key);

  final sideBarCangeNotifier = ChangeNotifierProvider<SideBarChangeNotifier>(
    (ref) => SideBarChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(sideBarCangeNotifier);

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 100),
      height: size.height - 100,
      width: state.width,
<<<<<<< HEAD
      decoration: const BoxDecoration(
        border: Border(
          right:
              BorderSide(width: .5, color: kcMedGrey, style: BorderStyle.solid),
        ),
        color: kcMedBeige,
=======
      decoration: BoxDecoration(
        color: kcLightBlue,
        borderRadius: BorderRadius.circular(10),
>>>>>>> Nikita
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Column(
              children: [
                SideBarItem(
                  collapsed: state.collapsed,
                  prefixImage: Image.asset(
                    "assets/images/home.png",
                    fit: BoxFit.fill,
                    height: 20,
                  ),
                  prefixIcon: const Icon(Icons.home),
                  text: "H o m e",
                  onTap: () {},
                ),
                SideBarItem(
                  collapsed: state.collapsed,
                  prefixImage: Image.asset(
                    "assets/images/weekly.png",
                    fit: BoxFit.fill,
                    height: 20,
                  ),
                  prefixIcon: const Icon(Icons.view_week),
                  text: "W e e k l y",
                  onTap: () {},
                ),
                SideBarItem(
                  collapsed: state.collapsed,
                  prefixImage: Image.asset(
                    "assets/images/starWhite.png",
                    fit: BoxFit.fill,
                    height: 20,
                  ),
                  text: "F a v o r i t e s",
                  onTap: () {},
                ),
              ],
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
                      fit: BoxFit.fill, height: 20)
                  : Image.asset("assets/images/collapse.png",
                      fit: BoxFit.fill, height: 20),
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
                  fit: BoxFit.fill, height: 20),
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
    this.fontSize = 15,
    this.fontWeight = FontWeight.bold,
    this.height = 30,
    this.width = 200,
    this.color,
<<<<<<< HEAD
    this.textColor = kcLightBeige,
=======
    this.textColor = kcLightBlue,
>>>>>>> Nikita
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
                ? prefixImage ?? prefixIcon
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
<<<<<<< HEAD
  Color _backgroundColor = kcLightBeige;
=======
  Color _backgroundColor = kcLightBlue;
>>>>>>> Nikita
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
<<<<<<< HEAD
    backgroundColor = val ? Colors.white : kcLightBeige;
=======
    backgroundColor = val ? kcMedBlue.withOpacity(.3) : kcLightBlue;
    textColor = val ? kcDarkBlue : kcDarkBlue.withOpacity(1);
>>>>>>> Nikita
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
