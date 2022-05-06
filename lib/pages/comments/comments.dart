import 'package:cookbook/components/components.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentsPage extends StatefulHookConsumerWidget {
  static const String id = '/comments';

  final Recipe recipe;

  const CommentsPage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // Get comments for certain recipe;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomPage(
      child: Center(
        child: SelectableText('Hello World'),
      ),
    );
  }
}
