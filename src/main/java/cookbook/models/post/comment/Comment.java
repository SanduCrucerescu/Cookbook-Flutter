package cookbook.models.post.comment;

import cookbook.models.member.Member;
import cookbook.models.post.Post;

public class Comment extends Post {
  private int postId;

  public Comment(Member creator, String body, int postID) {
    super(creator, body);
    this.postId = postID;
  }

}
