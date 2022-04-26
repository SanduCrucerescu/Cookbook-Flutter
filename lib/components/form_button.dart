part of components;

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool showShadow;
  final Color? color;
  final double? height, width;

  const FormButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color,
    this.height,
    this.width,
    this.showShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 40,
        width: width ?? 200,
        child: CustomButton(
          showShadow: showShadow,
          color: color,
          duration: const Duration(milliseconds: 200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 0,
              spreadRadius: .5,
              offset: const Offset(3, 3),
            ),
          ],
          onTap: onTap,
          child: Text(
            text,
            style: ksFormButtonStyle,
          ),
        ),
      ),
    );
  }
}
