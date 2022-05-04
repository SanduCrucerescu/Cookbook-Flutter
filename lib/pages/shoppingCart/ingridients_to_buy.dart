import 'dart:convert';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/image_picker.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/login/login.dart';
import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngridientsToBuy extends HookConsumerWidget {
  final String text;
  final Alignment position;
  final SelectedUserChangeNotifier2 state;

  IngridientsToBuy({
    required this.text,
    required this.position,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();

    double xSize = 600;
    return Padding(
      padding: const EdgeInsets.only(right: 40, bottom: 20, top: 20, left: 20),
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
          height: 600,
          width: 600,
          child: Column(
            children: [
              Container(
                height: 40,
                width: xSize,
                alignment: Alignment.topCenter,
                child: Text(
                  "Shopping List",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                child: Container(
                  // color: Color.fromARGB(255, 245, 245, 220),
                  alignment: Alignment.topLeft,
                  child: state.currIngridient != null
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            UserInfoField(
                              title: 'Name: ',
                              content: state.userName,
                              controller: nameController,
                              onTap: () {
                                state.currIngridient?.name =
                                    nameController.text;
                              },
                            ),
                            UserInfoField(
                              title: 'Email: ',
                              content: state.email,
                              controller: emailController,
                              onTap: () {
                                //state.currIngridient?.email = emailController.text;
                              },
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
  final VoidCallback onTap;
  final DatabaseManager dbManager = DatabaseManager();
  final TextEditingController controller;

  UserInfoField({
    required this.title,
    required this.content,
    required this.onTap,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                  Expanded(
                    child: CustomTextField(
                      controller: controller,
                      height: 15,
                      width: 230,
                      isShadow: false,
                      backgroundColor: Colors.transparent,
                      hintText: content,
                      fontSize: 12,
                    ),
                  )
                ],
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
                onTap: () => onTap(),
                child: const Center(
                  child: Text('Remove'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
