import 'dart:ui';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/get_image_from_blob.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/get_comments.dart';
import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/post/comment/comment.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/pages/comments/comments_controller.dart';
import 'package:cookbook/pages/messages/message_textfield.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postIdProvider = StateProvider<int>((ref) => 0);
final isPostCommentProvider = StateProvider<bool>((ref) => true);

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(commentsProvider).comments =
          await getComments(id: widget.recipe.id);
      setState(() {});
    });
    ref.read(postIdProvider.notifier).state = widget.recipe.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentsProvider);
    final Size size = MediaQuery.of(context).size;
    final isPostComment = ref.read(isPostCommentProvider.notifier).state;
    final TextEditingController tec = useTextEditingController();
    String? reply;

    if (isPostComment) {
      reply = 'Commenting on ' + widget.recipe.title;
    } else {
      if (state.comments != null) {
        for (Comment c in state.comments!) {
          if (c.id == ref.read(postIdProvider.notifier).state) {
            reply = 'Replying to ' + c.creator.email;
          }
        }
      }
    }

    return CustomPage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          state.comments == null
              ? const CircularProgressIndicator()
              : Expanded(
                  child: SizedBox(
                    height: size.height - 200,
                    child: ListView.builder(
                      itemCount: state.comments!.length,
                      itemBuilder: (context, idx) {
                        return CommentTile(comment: state.comments![idx]);
                      },
                    ),
                  ),
                ),
          Container(
            color: kcLightBeige,
            // padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    // height: 30,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kcMedBeige,
                      border: Border.all(
                        width: .5,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: InkWell(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: isPostComment
                                  ? 'Commenting on '
                                  : 'Replying to ',
                              style: const TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: reply,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      // child: Text('$reply'),
                    ),
                  ),
                ),
                MessageTextField(
                  controller: tec,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  onSubmitted: () async {
                    print(tec.text);
                    final Member member = await getMember(
                      InheritedLoginProvider.of(context).userData!['email'],
                    );
                    await sendComment(
                      postId: ref.read(postIdProvider.notifier).state,
                      member: member,
                      content: tec.text,
                      isPostComment:
                          ref.read(isPostCommentProvider.notifier).state,
                    );
                    tec.clear();
                    setState(() {});
                  },
                ),
                // Row(
                //   children: [
                //     CustomTextField(
                //       isShadow: false,
                //       letterSpacing: 1,
                //       width: size.width - 420,
                //       height: 50,
                //       maxLines: 5,
                //       controller: tec,
                //     ),
                //     CustomButton(
                //       border: const Border(
                //           left: BorderSide(
                //               color: kcMedGrey,
                //               width: .5,
                //               style: BorderStyle.solid)),
                //       duration: const Duration(milliseconds: 50),
                //       color: Colors.white,
                //       height: 50,
                //       width: 200,
                //       onTap: () async {
                //         final Member member = await getMember(
                //           InheritedLoginProvider.of(context).userData!['email'],
                //         );
                //         await sendComment(
                //           postId: ref.read(postIdProvider.notifier).state,
                //           member: member,
                //           content: tec.text,
                //           isPostComment:
                //               ref.read(isPostCommentProvider.notifier).state,
                //         );
                //         setState(() {});
                //       },
                //       child: const Text('S e n d', style: ksFormButtonStyle),
                //     ),
                //   ],
                // ),
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
  required bool isPostComment,
}) async {
  DatabaseManager dbManager = await DatabaseManager.init();
  dbManager.insert(table: 'comments', fields: [
    'member_email, content, post_id, time, post_comment'
  ], data: {
    'member_email': member.email,
    'content': content,
    'post_id': postId,
    'time': DateTime.now().toIso8601String(),
    'post_comment': isPostComment,
  });

  // dbManager.query(query: q);
}

class CommentTile extends StatefulHookConsumerWidget {
  final Comment comment;

  const CommentTile({
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  _CommentTileState createState() => _CommentTileState();
}

class _CommentTileState extends ConsumerState<CommentTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final comment = widget.comment;

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
                              onTap: () {
                                ref.read(isPostCommentProvider.notifier).state =
                                    false;
                                ref.read(postIdProvider.notifier).state =
                                    comment.id;
                              },
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
