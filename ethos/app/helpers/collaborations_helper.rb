module CollaborationsHelper
  def can_collaborate?(ideaboard)
    signed_in? && ideaboard.user != current_user &&
      !ideaboard.collaborations.include?(current_user)
  end
end
