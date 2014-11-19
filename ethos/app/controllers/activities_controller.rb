class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    params[:page] ||= 1
    # collaborators_id = current_user.@ideaboards.map do |ideaboard|
      # ideaboard.collaborators.map(&:id)
    # end
    @activities = Activity.for_user(current_user, params)
    respond_with @activities
  end
end
