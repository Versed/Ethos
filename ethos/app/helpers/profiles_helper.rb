module ProfilesHelper
  def can_comment_profile?(user, profile)
    profile.friends.include?(user) || user === profile
  end
end
