import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'admin_page.dart';

class UserInfo extends StatelessWidget {
  final String text;
  final position;
  final SelectedUserChangeNotifier state;

  const UserInfo({
    required this.text,
    required this.position,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double xSize = 600;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          height: 278,
          width: 600,
          //Title of the rectangle
          child: Column(
            children: [
              Container(
                height: 40,
                width: xSize,
                alignment: Alignment.topCenter,
                child: Text(
                  state.userName,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                child: Container(
                  // color: Color.fromARGB(255, 245, 245, 220),
                  alignment: Alignment.topLeft,
                  child: state.currMember == null
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            UserInfoField(
                                title: 'Name: ',
                                content: state.userName,
                                parameterToUpdate: state.currMember!.name),
                            UserInfoField(
                              title: 'Email: ',
                              content: state.email,
                              parameterToUpdate: state.currMember!.email,
                            ),
                            UserInfoField(
                              title: 'Image: ',
                              content: 'some image', //TODO: replace with image
                              parameterToUpdate: state.currMember!.name,
                            ),
                            CustomButton(
                              color: kcMedBeige,
                              duration: Duration(milliseconds: 100),
                              onTap: () async {
                                DatabaseManager dbManager =
                                    await DatabaseManager.init();
                                Member member = state.currMember!;
                                dbManager.update(
                                  table: 'members',
                                  params: {
                                    'name': member.name,
                                    'emai': member.email,
                                    'password': member.password,
                                    'profile_pic:': member
                                        .name, // TODO : Change to profilePicture
                                  },
                                  where: {'email': member.email},
                                );
                              },
                              child: const Text('Apply'),
                            ),
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoField extends HookConsumerWidget {
  final String title, content;
  String parameterToUpdate;
  final DatabaseManager dbManager = DatabaseManager();

  UserInfoField({
    required this.title,
    required this.content,
    required this.parameterToUpdate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tec = useTextEditingController();

    return SizedBox(
      width: 410,
      child: Container(
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Expanded(
                  child: Container(
                    height: 40,
                    width: 300,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.only(left: 5),
                    color: kcMedBeige,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title),
                        Container(
                          child: Expanded(
                            child: CustomTextField(
                              controller: tec,
                              height: 15,
                              width: 230,
                              isShadow: false,
                              backgroundColor: Colors.transparent,
                              hintText: content,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  color: kcMedBeige,
                  width: 100,
                  height: 40,
                  child: InkWell(
                    onTap: () {
                      print(tec.text);
                      parameterToUpdate = tec.text;
                    },
                    child: const Center(
                      child: Text('Save'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
