import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngridientsToBuy extends HookConsumerWidget {
  final String text;
  final Alignment position;
  final SelectedIngridientChangeNotifier2 state;

  IngridientsToBuy({
    required this.text,
    required this.position,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double xSize = 600;
    return Container(
      padding: const EdgeInsets.only(right: 40, bottom: 20, top: 20, left: 20),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              height: 500,
              width: xSize,
              child: SizedBox(
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: null,
                  child: ListView.builder(
                      controller: null,
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Ingridient name : Price 10 €'),
                        );
                      }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                height: 100,
                width: xSize,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: () {}, child: Text("Some Button")),
                      TextButton(
                          onPressed: () {}, child: Text("Another Button")),
                      TextButton(
                          onPressed: () {},
                          child: Text("And another one Button"))
                    ]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Text("Total Cost: 40€")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class UserInfoField extends HookConsumerWidget {
//   final String title, content;
//   final VoidCallback onTap;
//   final DatabaseManager dbManager = DatabaseManager();
//   final TextEditingController controller;

//   UserInfoField({
//     required this.title,
//     required this.content,
//     required this.onTap,
//     required this.controller,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SizedBox(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Container(
//               height: 40,
//               width: 300,
//               margin: const EdgeInsets.symmetric(vertical: 5),
//               padding: const EdgeInsets.only(left: 5),
//               color: kcMedBeige,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(title),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: controller,
//                       height: 15,
//                       width: 230,
//                       isShadow: false,
//                       backgroundColor: Colors.transparent,
//                       hintText: content,
//                       fontSize: 12,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: Container(
//               color: kcMedBeige,
//               width: 100,
//               height: 40,
//               child: InkWell(
//                 onTap: () => onTap(),
//                 child: const Center(
//                   child: Text('Remove'),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
