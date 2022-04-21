import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';

// *This code is for the image (pfp)

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget(
      {Key? key, required this.imagePath, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

// *This determines how the image looks in this case circle shape.

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 200,
          height: 200,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

// * This is for the edit icon, edit icon background and the outline.

  Widget buildEditIcon(Color color) => buildCircle(
        color: kcLightBeige,
        all: 4,
        child: buildCircle(
          color: Color.fromARGB(255, 88, 180, 255),
          all: 6,
          child: const Icon(
            Icons.edit,
            // color: Colors.white,
            size: 35,
          ),
        ),
      );

// * This is for the shape of the edit icon background.

  Widget buildCircle(
          {required Color color, required double all, required Widget child}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
