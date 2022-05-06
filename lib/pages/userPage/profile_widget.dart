import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/messages/inbox_widget.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';

// *This code is for the image (pfp)
class ProfileWidget extends StatelessWidget {
  Member user;

  ProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          UserProfilePicture(
            user: user,
          ),
          const Positioned(
            bottom: 0,
            right: 4,
            child: CircleWidget(),
          ),
        ],
      ),
    );
  }
}

// * This is for the edit icon, edit icon background and the outline.
class CircleWidget extends StatelessWidget {
  const CircleWidget({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return buildCircle(
      color: kcLightBeige,
      all: 4,
      child: buildCircle(
        color: Colors.black,
        all: 10,
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}

// *This determines how the image looks, in this case circle shape.
class UserProfilePicture extends StatelessWidget {
  Member user;

  UserProfilePicture({Key? key, required final this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Profile_Pic(
          member: user,
        ),
      ),
    );
  }
}
