package cookbook.models.recipe;

import cookbook.models.ingredient.Ingredient;
import cookbook.models.tag.Tag;

import java.sql.Blob;
import java.util.List;

public class Recipe {
    private String id;
    private String title;
    private String description;
    private List<Ingredient> ingredients;
    private double amountFactor;
    private String instructions;
    private String ownerEmail;
    private List<Tag> tags;
    private Blob recipe_pic;

    public Recipe(
            String id,
            String title,
            String description,
            String instructions,
            String ownerEmail,
            Blob recipe_pic
    ) {
        this.setId(id);
        this.setTitle(title);
        this.setDescription(description);
        this.setInstructions(instructions);
        this.setOwnerEmail(ownerEmail);
        this.setRecipe_pic(recipe_pic);
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Ingredient> getIngredients() {
        return ingredients;
    }

    public void setIngredients(List<Ingredient> ingredients) {
        this.ingredients = ingredients;
    }

    public void addIngredient(Ingredient ingredient) {
        ingredients.add(ingredient);
    }

    public void removeIngredient(Ingredient ingredient) {
        ingredients.remove(ingredient);
    }

    public double getAmountFactor() {
        return amountFactor;
    }

    public void setIngredientAmountFactor(double amountFactor) {
        this.amountFactor = amountFactor;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public String getOwnerEmail() {
        return ownerEmail;
    }

    public void setOwnerEmail(String ownerEmail) {
        this.ownerEmail = ownerEmail;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }

    public void addTag(Tag tag) {
        this.tags.add(tag);
    }

    public void removeTag(Tag tag) {
        this.tags.remove(tag);
    }

    public Blob getRecipe_pic() {
        return recipe_pic;
    }

    public void setRecipe_pic(Blob recipe_pic) {
        this.recipe_pic = recipe_pic;
    }
}
