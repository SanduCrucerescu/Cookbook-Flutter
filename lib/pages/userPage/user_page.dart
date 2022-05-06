import 'dart:ffi';
import 'dart:io';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/get_members.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/userPage/profile_widget.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../db/database_manager.dart';
import '../admin/admin_page.dart';

class UserPage extends ConsumerWidget {
  Member user;
  static const String id = '/user';
  UserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserPageState();
  }
}

class UserPageState extends HookConsumerWidget {
  get user => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return CustomPage(
      child: Container(
        color: kcLightBeige,
        width: size.width - 200,
        height: size.height - 100,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              // child: ProfileWidget(
              //   user:
              // imagePath: user.profilePicture,
              // onClicked: () async {
              //   final Map<String, dynamic>? imageData =
              //       await openImagePicker();
              //   if (imageData != null) {
              //     state.photo = imageData['String'];
              //     state.photoSuccessful = true;
              //     state.path = imageData['file'];
              //     state.text = imageData['name'];
              //   }
              // },
              // ),
              // child: const UsersColumn()),
              // const UserPageForm(user: ),
            ),
            // const UsersColumn()
            UserPageForm(user: user)
          ],
        ),
      ),
    );
  }
}

class UsersColumn extends StatefulWidget {
  const UsersColumn({
    Key? key,
  }) : super(key: key);

  @override
  State<UsersColumn> createState() => _UsersColumnState();
}

class _UsersColumnState extends State<UsersColumn> {
  DatabaseManager? dbManager;
  List<Member> members = [];
  List<Member> displayedmembers = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) async {
        members = await getMembers(context);
        displayedmembers = members;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    displayedmembers = [];

    if (members.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Column(children: const [CircularProgressIndicator()]),
      );
    } else {
      return Container(
        height: 698,
        width: 1000,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: ListView.builder(
          itemCount: displayedmembers.length,
          itemBuilder: (BuildContext context, int idx) {
            return Row(
              children: [
                UserProfilePicture(
                  user: displayedmembers[1],
                ),
                UserPageForm(user: displayedmembers[1])
              ],
            );
          },
        ),
      );
    }
  }
}

//todo: The photo picker and changer are yet to be implemented

class UserPageForm extends StatelessWidget {
  const UserPageForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Member user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserPageTextField(
          size: size,
          user: user,
          hintText: user.name,
          label: "Name",
        ),
        UserPageTextField(
          size: size,
          user: user,
          hintText: user.email,
          label: "Email",
        ),
        UserPageTextField(
          size: size,
          user: user,
          hintText: '********',
          label: "Password",
        ),
        Center(child: buildSaveButton())
      ],
    );
  }

//todo Add save button function
  Widget buildSaveButton() => SaveButton(
        text: 'Save Changes',
        onClicked: () {},
      );
}

class SaveButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const SaveButton({Key? key, required this.text, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.black,
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

class UserPageTextField extends StatelessWidget {
  final String hintText, label;
  final Size size;
  final Member user;

  const UserPageTextField({
    Key? key,
    required this.hintText,
    required this.size,
    required this.user,
    this.label = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SelectableText(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          CustomTextField(
            backgroundColor: Colors.transparent,
            isShadow: false,
            width: size.width,
            onChanged: (user) {},
            inputDecoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
