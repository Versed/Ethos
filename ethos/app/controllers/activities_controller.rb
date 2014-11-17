class ActivitiesController < ApplicationController
  respond_to :html, :json

  def index
    params[:page] ||= 1
    # collaborators_id = curent_user.@ideaboards.map do |ideaboard|
      # ideaboard.collaborators.map(&:id)
    # end
    @activities = Activity.for_user(curent_user, params)
    respond_with @activities
  end
end
