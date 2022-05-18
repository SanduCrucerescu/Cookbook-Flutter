import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/loadimage.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/get_comments.dart';
import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/comment/comment.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/pages/comments/comments_controller.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postIdProvider = StateProvider<int>((ref) => 0);

class CommentsPage extends StatefulHookConsumerWidget {
  static const String id = '/comments';

  final Recipe recipe;

  const CommentsPage({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      ref.read(commentsProvider).comments =
          await getComments(id: widget.recipe.id);
      //setState(() {});
    });
    ref.read(postIdProvider.notifier).state = widget.recipe.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentsProvider);
    final Size size = MediaQuery.of(context).size;

    final tec = useTextEditingController();

    return CustomPage(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, left: 5),
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: kcMedBeige,
                  border: Border.all(
                    color: kcMedGrey,
                    width: .5,
                    style: BorderStyle.solid,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height - 215,
            child: Center(
              child: state.comments == null
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: state.comments!.length,
                      itemBuilder: (context, idx) {
                        return CommentTile(comment: state.comments![idx]);
                      },
                    ),
            ),
          ),
          Container(
            height: 70,
            color: kcLightBeige,
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                CustomTextField(
                  isShadow: false,
                  letterSpacing: 1,
                  width: size.width - 420,
                  height: 50,
                  maxLines: 5,
                  controller: tec,
                ),
                CustomButton(
                  border: const Border(
                      left: BorderSide(
                          color: kcMedGrey,
                          width: .5,
                          style: BorderStyle.solid)),
                  duration: const Duration(milliseconds: 50),
                  color: Colors.white,
                  height: 50,
                  width: 200,
                  onTap: () async {
                    final Member member = await getMember(
                      InheritedLoginProvider.of(context).userData!['email'],
                    );
                    await sendComment(
                      postId: ref.read(postIdProvider.notifier).state,
                      member: member,
                      content: tec.text,
                    );
                    setState(() {});
                  },
                  child: const Text('S e n d', style: ksFormButtonStyle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> sendComment({
  required Member member,
  required int postId,
  required String content,
}) async {
  DatabaseManager dbManager = await DatabaseManager.init();
  dbManager.insert(table: 'comments', fields: [
    'member_email, content, post_id, time'
  ], data: {
    'member_email': member.email,
    'content': content,
    'post_id': postId,
    'time': DateTime.now().toIso8601String(),
  });

  // dbManager.query(query: q);
}

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(
        left: 5,
        top: 5,
      ),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: .5,
          ),
          // right: BorderSide(color: Colors.black, width: .5),
          top: BorderSide(
            color: Colors.black,
            width: .5,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: ClipOval(
                            child: comment.creator.profilePicture == null
                                ? Image.asset('assets/images/ph.png')
                                : Image.memory(
                                    getImageDataFromBlob(
                                        comment.creator.profilePicture!),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      size.width > 1300
                          ? Container(
                              height: 40,
                              width: 200,
                              decoration: const BoxDecoration(),
                              child: Center(
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    comment.creator.email,
                                    style: ksFormButtonStyle,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                Expanded(
                  flex: size.width > 1300 ? 3 : 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: size.width / 2),
                          child: SelectableText(comment.content),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(),
                            child: InkWell(
                              onTap: () {},
                              child: const Icon(Icons.reply),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(),
                            child: InkWell(
                              onTap: () {},
                              child: const Icon(Icons.settings),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              children: List.generate(
                comment.comments.length,
                (idx) => CommentTile(
                  comment: comment.comments[idx],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
