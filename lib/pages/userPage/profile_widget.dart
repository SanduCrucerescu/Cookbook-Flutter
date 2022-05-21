import 'package:cookbook/controllers/image_picker.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/messages/inbox_widget.dart';
import 'package:cookbook/pages/userPage/user_page_provider.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// *This code is for the image (pfp)
class ProfileWidget extends StatelessWidget {
  final Member member;
  final double? height, width;
  final EdgeInsets? margin;
  final double scale;

  const ProfileWidget({
    required this.member,
    this.height,
    this.width,
    this.margin,
    this.scale = 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height ?? 100) * scale,
      width: (width ?? 100) * scale,
      margin: margin ?? const EdgeInsets.only(top: 10),
      child: Center(
        child: Stack(
          children: [
            SizedBox(
              height: 100 * scale,
              width: 100 * scale,
              child: ProfilePic(
                member: member,
                height: 100 * scale,
                width: 100 * scale,
                scale: scale / 10,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 4,
              child: EditProfilePictureButton(
                scale: scale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// * This is for the edit icon, edit icon background and the outline.
class EditProfilePictureButton extends StatelessWidget {
  final double? scale;

  const EditProfilePictureButton({
    this.scale,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleWidget(
      color: kcLightBeige,
      padding: scale == null ? 4 : 4 * scale!,
      child: CircleWidget(
        color: Colors.black,
        padding: scale == null ? 10 : 5 * scale!,
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
          size: scale == null ? 25 : 15 * scale!,
        ),
      ),
    );
  }
}

class CircleWidget extends ConsumerWidget {
  const CircleWidget({
    Key? key,
    required this.color,
    required this.padding,
    required this.child,
  }) : super(key: key);

  final Color color;
  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipOval(
      child: InkWell(
        onTap: () async {
          ref.watch(userPageProvider).data!['imgData'] =
              await openImagePicker();
        },
        child: Container(
          padding: EdgeInsets.all(padding),
          color: color,
          child: child,
        ),
      ),
    );
  }
}
