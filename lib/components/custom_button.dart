part of components;

class CustomButton extends HookConsumerWidget {
  final Duration duration;
  final Function onTap;
  final double height;
  final double width;
  final double borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Widget? child;
  final bool showShadow;
  final Color? color;
  final EdgeInsets? margin, padding;

  CustomButton({
    required this.onTap,
    this.duration = const Duration(milliseconds: 200),
    this.margin,
    this.padding,
    this.child,
    this.width = 100,
    this.height = 30,
    this.borderRadius = 0,
    this.border,
    this.boxShadow,
    this.showShadow = true,
    this.color,
    Key? key,
  }) : super(key: key);

  final customButtonChangeNotifier =
      ChangeNotifierProvider<CustomButtonChangeNotifier>(
    (ref) => CustomButtonChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customButtonChangeNotifier);

    return AnimatedContainer(
      duration: duration,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? kcMedBeige,
        // borderRadius: BorderRadius.circular(borderRadius),
        border: state.hovering
            ? Border.all(
                color: Colors.black,
                width: 1.5,
                style: BorderStyle.solid,
              )
            : border,
        boxShadow: showShadow
            ? state.hovering
                ? boxShadow
                : null
            : null,
      ),
      child: InkWell(
        onHover: (val) {
          state.hovering = val;
        },
        onTap: () => onTap(),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class CustomButtonChangeNotifier extends ChangeNotifier {
  bool _hovering = false;

  bool get hovering => _hovering;

  set hovering(bool val) {
    _hovering = val;
    notifyListeners();
  }
}
