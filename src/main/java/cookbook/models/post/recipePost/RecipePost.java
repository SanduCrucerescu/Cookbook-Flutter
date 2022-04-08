package cookbook.models.post.recipePost;

import cookbook.models.member.Member;
import cookbook.models.post.Post;
import cookbook.models.recipe.Recipe;

public class RecipePost extends Post {
  private Recipe recipe;

  public RecipePost(Member creator, String body, Recipe recipe) {
    super(creator, body);
    this.recipe = recipe;
  }

}
