<<<<<<< HEAD
part of ui_components;
=======
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
>>>>>>> Nikita

class CustomButton extends HookConsumerWidget {
  final Duration duration;
  final Function onTap;
  final double height;
  final double width;
  final double borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Widget? child;

  CustomButton({
    required this.duration,
    required this.onTap,
    this.child,
    this.width = 100,
    this.height = 30,
    this.borderRadius = 0,
    this.border,
    this.boxShadow,
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
      decoration: BoxDecoration(
        color: kcPrimaryGreen,
        borderRadius: BorderRadius.circular(borderRadius),
        border: state.hovering
            ? Border.all(
                color: Colors.black,
                width: .5,
                style: BorderStyle.solid,
              )
            : null,
        boxShadow: state.hovering ? boxShadow : null,
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
