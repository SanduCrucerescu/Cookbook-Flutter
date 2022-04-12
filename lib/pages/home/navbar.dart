import 'package:cookbook/components/ui_components.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBar extends HookConsumerWidget {
  final Color backgroundColor;
  final Color widgetColor;
  final String? logoUrl;
  final Image? profilePicture;
  final List<Widget>? actions;
  final Border? border;

  const NavBar({
    this.backgroundColor = kcLightBeige,
    this.widgetColor = kcMedBeige,
    this.logoUrl,
    this.profilePicture,
    this.actions,
    this.border,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 100,
      decoration: BoxDecoration(
<<<<<<< HEAD
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: NavBarItemBackground(
              child: Image.asset('assets/images/temp_logo.png'),
            ),
          ),
          Expanded(
            flex: 5,
            child: CustomTextField(
              isShadow: false,
              height: 60,
              prefixIcon: const Icon(
                Icons.expand_more,
                color: Colors.black,
                size: 35,
              ),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: kcMedGrey, width: 1, style: BorderStyle.solid),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 1,
            child: NavBarItemBackground(
              width: 110,
              paddingVertical: 10,
              child: CircleAvatar(
                child: Image.asset('assets/images/ph.png'),
              ),
            ),
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

  const NavBarItemBackground({
    required this.child,
    Key? key,
    this.borderRadius,
    this.width,
    this.height,
    this.paddingVertical,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 5, vertical: paddingVertical ?? 0),
        height: height ?? 80,
        width: width ?? 160,
        decoration: BoxDecoration(
          color: kcMedBeige,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
        child: child,
=======
        color: kcMedBlue,
        borderRadius: BorderRadius.circular(10),
>>>>>>> Nikita
      ),
    );
  }
}
