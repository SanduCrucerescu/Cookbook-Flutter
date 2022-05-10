import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/loadimage.dart';
import 'package:cookbook/db/queries/get_comments.dart';
import 'package:cookbook/models/post/comment/comment.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/pages/comments/comments_controller.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      ref.read(commentsProvider).comments =
          await getComments(id: widget.recipe.id);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentsProvider);

    return CustomPage(
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
    );
  }
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
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.black, width: .5),
          right: BorderSide(color: Colors.black, width: .5),
          top: BorderSide(color: Colors.black, width: .5),
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
                      Container(
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
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
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
