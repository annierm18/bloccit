module CommentsHelper
  def user_is_authorized_for_comment?(comment)
<<<<<<< HEAD
    current_user && (current_user == comment.user || current_user.admin?)
=======
     current_user && (current_user == comment.user || current_user.admin?)
>>>>>>> checkpoint-28-railscomments
  end
end
