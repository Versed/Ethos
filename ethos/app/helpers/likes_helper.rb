module LikesHelper
  def can_like?(ideaboard)
    signed_in? && !ideaboard.likes.any?{|like| like.user_id == current_user.id}
  end

  def can_unlike?(ideaboard)
    signed_in? && ideaboard.likes.any?{|like| like.user_id == current_user.id}
  end
end
