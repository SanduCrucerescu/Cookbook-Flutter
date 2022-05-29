import 'dart:convert';
import 'dart:typed_data';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/components/refresh_progress_indicator.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/messages/inbox_widget.dart';
import 'package:cookbook/pages/userPage/profile_widget.dart';
import 'package:cookbook/pages/userPage/user_page_provider.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';

import '../../controllers/get_image_from_blob.dart';

class UserPage extends StatefulHookConsumerWidget {
  static const String id = '/user';
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  Member? member;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final data = InheritedLoginProvider.of(context).userData;
      print(data!['email']);
      if (data != null) {
        member = await getMember(data['email']);
        Blob? img = member!.profilePicture;
        ref.watch(userPageProvider).data!['imgData'] = {"file": img};
        setState(() {});
      }
      ref.watch(userPageProvider).saved = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomPage(
      child: Container(
        color: kcLightBeige,
        width: size.width - 200,
        height: size.height - 100,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            member == null ? const SizedBox() : ProfileWidget(member: member!),
            // const UsersColumn()
            UserPageForm(
              user: member,
            ),
          ],
        ),
      ),
    );
  }
}

class UserPageForm extends HookConsumerWidget {
  final Member? user;

  const UserPageForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(userPageProvider);
    final TextEditingController nameController = useTextEditingController();
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    return user == null
        ? const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: progressIndicator,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserPageTextField(
                size: size,
                user: user!,
                hintText: user!.name,
                label: "Name",
                controller: nameController,
              ),
              UserPageTextField(
                size: size,
                user: user!,
                hintText: user!.email,
                label: "Email",
                controller: emailController,
              ),
              UserPageTextField(
                size: size,
                user: user!,
                hintText: user!.password,
                label: "Password",
                controller: passwordController,
              ),
              state.saved
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: SelectableText(
                          state.text,
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Center(
                child: SaveButton(
                  text: 'Save Changes',
                  onClicked: () async {
                    state.saved = true;
                    state.text = "Data saved successfuly";
                    print(state.saved);
                    await onSave(
                      name: nameController.text,
                      email: emailController.text,
                      member: user,
                      password: passwordController.text,
                      ref: ref,
                      context: context,
                    );
                  },
                ),
              ),
            ],
          );
  }
}

class SaveButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const SaveButton({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

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
  final TextEditingController controller;

  const UserPageTextField({
    Key? key,
    required this.controller,
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
            controller: controller,
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

Future<void> onSave({
  required String name,
  required String email,
  required Member? member,
  required String password,
  required WidgetRef ref,
  required BuildContext context,
}) async {
  final data = ref.read(userPageProvider).data;
  final userData = InheritedLoginProvider.of(context).userData;
  DatabaseManager dbManager = await DatabaseManager.init();
  String img64;
  String emailToUpdate = userData!['email'];

  final file = data!['imgData']['file']!;

  if (file.toString().startsWith("/")) {
    img64 = file.toString();
  } else {
    final bytes = file.readAsBytesSync();
    img64 = base64Encode(bytes!);
  }

  Map<String, dynamic> toUpdate = {};

  if (name != '') {
    toUpdate['username'] = name;
    userData['username'] = name;
  }

  if (email != '') {
    toUpdate['email'] = email;
    userData['email'] = email;
  }

  if (password != '') {
    toUpdate['password'] = password;
    userData['password'] = password;
  }

  if (file != null) {
    toUpdate['profile_pic'] = img64;
    userData['profilePic'] = Blob.fromString(img64);
  }

  dbManager.update(
    table: 'members',
    set: toUpdate,
    where: {
      'email': emailToUpdate,
    },
  );
}
