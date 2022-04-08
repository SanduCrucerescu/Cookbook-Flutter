package cookbook.models.post;

import cookbook.models.member.Member;
import cookbook.models.post.comment.Comment;
import java.util.ArrayList;

/**
 * This represents a post in this app.
 * There are two types of posts: Comments and RecipePosts,
 * which both inherit from this class.
 */
public abstract class Post {
  private final Member creator;
  private String body;
  private int likes = 0;
  private int dislikes = 0;
  private ArrayList<Comment> comments = new ArrayList<Comment>();

  public Post(Member creator, String body) {
    this.creator = creator;
    this.body = body;
  }

  public void comment(Comment post) {
    this.comments.add(post);
  }

  public ArrayList<Comment> getComments() {
    return this.comments;
  }

  public Member getCreator() {
    return creator;
  }

  public String getBody() {
    return body;
  }

  public void setBody(String body) {
    this.body = body;
  }

  public  int getLikes() {
    return likes;
  }

  public void addLike() {
    likes++;
  }

  public void removeLike() {
    likes--;
  }

  public  int getDislikes() {
    return likes;
  }

  public void addDislike() {
    dislikes++;
  }

  public void removeDislike() {
    dislikes--;
  }
}
