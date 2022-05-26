import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/tag/tag.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Tag>> getTagsFromId(int id) async {
  final DatabaseManager dbManager = await DatabaseManager.init();
  List<Tag> tagsList = [];

  Results? tags = await dbManager.query(query: """
SELECT tags.id, tags.name
FROM recipes_has_tags as recipe_tags
INNER JOIN recipes 
ON recipe_tags.recipes_id = recipes.id 
INNER JOIN tags
ON recipe_tags.tags_id = tags.id
WHERE recipe_tags.recipes_id = $id;""");

  for (var tag in tags!) {
    final tagClass = Tag(id: tag.fields['id'], name: tag.fields['name']);
    tagsList.add(tagClass);
  }
  dbManager.close();
  return tagsList;
}
