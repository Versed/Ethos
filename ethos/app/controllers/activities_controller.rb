class ActivitiesController < ApplicationController
  def index
    friend_ids = current_user.friends.map(&:id)
    # collaborators_id = curent_user.@ideaboards.map do |ideaboard|
      # ideaboard.collaborators.map(&:id)
    # end

    @activities = Activity.where("user_id in (?)", friend_ids.push(current_user.id)).order("created_at desc").all
  end
end
