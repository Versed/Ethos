class ActivitiesController < ApplicationController
  def index
    params[:page] ||= 1
    # collaborators_id = curent_user.@ideaboards.map do |ideaboard|
      # ideaboard.collaborators.map(&:id)
    # end
    @activities = Activity.for_user(curent_user, params)
  end
end
