part of components;

class NavBar extends HookConsumerWidget {
  final Color backgroundColor;
  final Color widgetColor;
  final String? logoUrl;
  final Image? profilePicture;
  final List<Widget>? actions;
  final Border? border;
  final bool showSearchBar;
  final double? height, width;

  const NavBar({
    this.backgroundColor = kcLightBeige,
    this.widgetColor = kcMedBeige,
    this.logoUrl,
    this.profilePicture,
    this.actions,
    this.border,
    this.showSearchBar = true,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarItemBackground(
            child: Image.asset('assets/images/temp_logo.png'),
          ),
          showSearchBar
              ? CustomTextField(
                  isShadow: false,
                  height: 60,
                  width: 1000,
                  prefixIcon: const Icon(
                    Icons.expand_more,
                    color: Colors.black,
                    size: 35,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: kcMedGrey, width: 1, style: BorderStyle.solid),
                )
              : const SizedBox(),
          NavBarItemBackground(
            width: 110,
            paddingVertical: 10,
            child: CircleAvatar(
              child: Image.asset('assets/images/ph.png'),
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
          color: kcMedBeige,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
        child: child,
      ),
    );
  }
}
