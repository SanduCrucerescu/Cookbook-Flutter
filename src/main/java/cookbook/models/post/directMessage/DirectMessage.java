package cookbook.models.post.directMessage;

import cookbook.models.member.Member;
import cookbook.models.post.Post;
import cookbook.models.post.comment.Comment;

public class DirectMessage extends Post {

  public DirectMessage(Member creator, String body) {
    super(creator, body);
  }

}
