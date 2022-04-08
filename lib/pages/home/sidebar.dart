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
      margin: const EdgeInsets.all(10),
      height: size.height,
      width: state.width,
      decoration: BoxDecoration(
        color: kcLightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 10,
            child: Column(
              children: [
                SideBarItem(
                  collapsed: state.collapsed,
                  text: "H O M E",
                  onTap: () {},
                ),
                SideBarItem(
                  collapsed: state.collapsed,
                  text: "W E E K L Y",
                  onTap: () {},
                ),
                SideBarItem(
                  collapsed: state.collapsed,
                  text: "F A V O R I T E S",
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
            child: TextButton(
              onPressed: () {
                state.collapsed = !state.collapsed;
                if (state.width == 50) {
                  state.width = 200;
                } else {
                  state.width = 50;
                }
              },
              child: const Text("Collapse"),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoginPage.id);
              },
              child: const Text("Collapse"),
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
  final IconData? prefixIcon, suffixIcon;
  final BorderRadius? borderRadius;
  SideBarItem({
    required this.text,
    required this.onTap,
    required this.collapsed,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.height = 30,
    this.width = 200,
    this.color,
    this.textColor = kcLightBlue,
    this.duration = const Duration(milliseconds: 0),
    this.accentColor,
    this.shadow = true,
    this.margin = 10,
    this.padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  final _hoveringNotifier = ChangeNotifierProvider<SideBarItemChangeNotifier>(
    (ref) => SideBarItemChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hovering = ref.watch(_hoveringNotifier);

    return AnimatedContainer(
      duration: duration,
      margin: const EdgeInsets.only(bottom: 10),
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          color: hovering.backgroundColor,
          borderRadius: BorderRadius.circular(3) // borderRadius,
          ),
      child: InkWell(
        onTap: onTap,
        onHover: (val) => hovering.onHover(val),
        child: Center(
          child: collapsed
              ? const Icon(Icons.add)
              : Text(
                  text,
                  // textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: hovering.textColor,
                  ),
                ),
        ),
      ),
    );
  }
}

class SideBarItemChangeNotifier extends ChangeNotifier {
  bool _hovering = false;
  bool _expanded = false;
  Color _backgroundColor = kcLightBlue;
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
    backgroundColor = val ? kcMedBlue.withOpacity(.3) : kcLightBlue;
    textColor = val ? kcDarkBlue : kcDarkBlue.withOpacity(1);
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
