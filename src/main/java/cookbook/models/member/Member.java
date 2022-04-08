package cookbook.models.member;

import cookbook.models.recipe.Recipe;

import java.sql.Blob;
import java.util.List;

/**
 * This represents a user in the app.
 */
public class Member {
    private String username;
    private String email;
    private String password;
    private List<Recipe> favorites;
    private List<Recipe> recipes;
    private Blob profile_picture;

    /**
     * Constructor.
     */
    public Member(
            String username,
            String email,
            String password,
            List<Recipe> favorites,
            List<Recipe> recipes,
            Blob profile_picture) {
        this.setUsername(username);
        this.setPassword(password);
        this.setEmail(email);
        this.setFavorites(favorites);
        this.setRecipes(recipes);
        this.setProfile_picture(profile_picture);
    }

    public Member() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        // TODO : Hash the password before storing
        this.password = password;
    }

    public List<Recipe> getFavorites() {
        return favorites;
    }

    private void setFavorites(List<Recipe> favorites) {
        this.favorites = favorites;
    }

    public void addFavorite(Recipe favorite) {
        this.favorites.add(favorite);
    }

    public List<Recipe> getRecipes() {
        return recipes;
    }

    private void setRecipes(List<Recipe> recipes) {
        this.recipes = recipes;
    }

    public void addRecipe(Recipe recipe) {
        this.recipes.add(recipe);
    }

    public void setProfile_picture(Blob profile_picture) {
        this.profile_picture = profile_picture;
    }

    public Blob getProfile_picture() {
        return profile_picture;
    }

    public String toString() {
        return username + ":" + email;
    }
}
