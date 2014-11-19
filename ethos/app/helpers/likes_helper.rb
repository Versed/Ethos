module LikesHelper
  def can_like?(ideaboard)
    signed_in? && !ideaboard.likes.include?(current_user.id)
  end

  def can_unlike?(ideaboard)
    signed_in? && ideaboard.likes.include?(current_user.id)
  end
end
