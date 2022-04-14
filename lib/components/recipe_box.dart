part of components;

class RecipeBox extends HookConsumerWidget {
  final String id;
  final String title;
  final String shortDescription;
  final String longDescription;
  final double quantity;
  final String creatorEmail;
  final List<String> tags;
  final Image image;

  const RecipeBox({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.quantity,
    required this.creatorEmail,
    required this.tags,
    required this.image,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
