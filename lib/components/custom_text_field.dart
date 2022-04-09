part of ui_components;

class CustomTextField extends ConsumerWidget {
  final Border? border;
  final BorderRadius? borderRadius;
  final TextAlign textAlign;
  final double width, height;
  final double? wordSpacing, letterSpacing;
  final Color backgroundColor, textColor;
  final Color? accentColor;
  final String? hintText;
  final Icon? prefixIcon, suffixIcon;
  final AssetImage? prefixImage, suffixImage;
  final TextInputType inputType;
  final EdgeInsets? margin, padding;
  final Duration duration;
  final VoidCallback? onClickSuffix;
  final TextBaseline? textBaseline;
  final TextStyle? textStyle;
  final InputDecoration? inputDecoration;
  final String? autofillHints;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? enabled;
  final bool autofocus, isShadow;
  bool obscureText;
  final FocusNode? focusNode;
  final int? minLines, maxLines;
  final ValueChanged<String>? onChanged;
  final Function? validator;
  final GestureTapCallback? onTap;
  TextEditingController? controller;

  CustomTextField({
    this.width = 500,
    this.height = 70,
    this.inputType = TextInputType.text,
    this.accentColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.wordSpacing = 3.0,
    this.letterSpacing = 3.0,
    this.fontSize = 16,
    this.autofocus = false,
    this.obscureText = false,
    this.isShadow = true,
    this.duration = const Duration(milliseconds: 300),
    this.minLines = 1,
    this.maxLines = 1,
    this.validator,
    this.fontStyle,
    this.autofillHints,
    this.textStyle,
    this.border,
    this.borderRadius,
    this.inputDecoration,
    this.padding,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixImage,
    this.suffixImage,
    this.margin,
    this.onClickSuffix,
    this.textBaseline,
    this.fontWeight,
    this.enabled,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.controller,
    this.textAlign = TextAlign.start,
    Key? key,
  }) : super(key: key);

  final statusProvider = ChangeNotifierProvider<TextFieldNotifier>(
    (ref) => TextFieldNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(statusProvider);

    return AnimatedContainer(
      duration: duration,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: isShadow
            ? [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  spreadRadius: .5,
                )
              ]
            : null,
        border: border,
      ),
      child: Stack(
        children: <Widget>[
          InkWell(
            // onHover: (val) => status.onTextFieldHover(val),
            onTap: () async {
              if (suffixIcon == null &&
                  controller != null &&
                  obscureText != true) {
                controller!.clear();
              } else {
                status.obscured = true;
              }
              status.obscured = false;
            },
            child: SuffixIconWidget(
              suffixIcon: suffixIcon,
              suffixImage: suffixImage,
              obscureText: obscureText,
              textColor: textColor,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: prefixIcon != null
                  ? PrefixIconWidget(
                      prefixIcon: prefixIcon,
                      prefixImage: prefixImage,
                      status: status,
                      backgroundColor: backgroundColor,
                      accentColor: accentColor,
                    )
                  : const SizedBox(width: 20),
            ),
          ),
          Center(
            child: Container(
              margin: prefixIcon != null
                  ? const EdgeInsets.only(right: 50, left: 50)
                  : const EdgeInsets.only(right: 50, left: 20),
              child: TextFormField(
                textAlign: textAlign,
                controller: controller,
                cursorWidth: 1.5,
                cursorColor: textColor,
                obscureText: obscureText ? !status.obscured : false,
                keyboardType: inputType,
                style: textStyle ??
                    GoogleFonts.montserrat(
                      fontStyle: fontStyle,
                      fontWeight: fontWeight,
                      wordSpacing: wordSpacing,
                      letterSpacing: letterSpacing,
                      textBaseline: textBaseline,
                      fontSize: fontSize,
                      color: textColor,
                    ),
                autofocus: autofocus,
                focusNode: focusNode,
                enabled: enabled,
                maxLines: maxLines,
                minLines: minLines,
                onChanged: onChanged,
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                validator: (val) => inputType == TextInputType.emailAddress
                    ? val != null
                        ? null
                        : "Please enter a valid email"
                    : (val != null && val.length > 8) || !obscureText
                        ? null
                        : "Password should be 8 character long",
                textInputAction: TextInputAction.next,
                autofillHints: [autofillHints ?? ""],
                decoration: inputDecoration ??
                    InputDecoration(
                      hintStyle: TextStyle(
                        color: textColor.withOpacity(.3),
                      ),
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                // cursorColor: isFocus ? accentColor : backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrefixIconWidget extends StatelessWidget {
  const PrefixIconWidget({
    Key? key,
    required this.status,
    required this.backgroundColor,
    required this.accentColor,
    this.onPrefixTap,
    this.prefixIcon,
    this.prefixImage,
  }) : super(key: key);

  final Icon? prefixIcon;
  final AssetImage? prefixImage;
  final TextFieldNotifier status;
  final Color backgroundColor;
  final Color? accentColor;
  final Function? onPrefixTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPrefixTap,
      child: prefixImage == null
          ? Icon(
              prefixIcon?.icon,
              color: accentColor,
              size: prefixIcon?.size,
            )
          : ImageIcon(prefixImage),
    );
  }
}

class SuffixIconWidget extends StatelessWidget {
  const SuffixIconWidget({
    Key? key,
    required this.suffixIcon,
    required this.obscureText,
    required this.textColor,
    this.suffixImage,
  }) : super(key: key);

  final Icon? suffixIcon;
  final AssetImage? suffixImage;
  final bool obscureText;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      alignment: Alignment.centerRight,
      child: suffixImage == null
          ? Icon(
              (suffixIcon == null && obscureText == false)
                  ? Icons.close
                  : Icons.visibility,
              color: textColor,
            )
          : ImageIcon(suffixImage),
    );
  }
}
