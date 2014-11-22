class CollaborationsController < ApplicationController
  before_filter :setup_ideaboard

  def index
  end

  def new
    @collaboration = @ideaboard.collaborations.new
  end

  def create
    @collaboration = Collaboration.request(current_user, @ideaboard)

    if @collaboration.new_record?
      flash[:error] = "There was a problem creating the collaboration request."
      redirect_to ideaboard_path(@ideaboard)
    else
      flash[:success] = "Collaboration request sent."
      redirect_to ideaboard_path(@ideaboard)
    end
  end

  def accept
    if @collaboration.accept!
      # add activity to ideaboard
      flash[:success] = "Collaborator added."
    else
      flash[:error] = "Could not accept collaboration request."
    end
    redirect_to collaborations_path
  end

  private
  def setup_ideaboard
    @ideaboard = Ideaboard.includes(:collaborations).find(params[:id])
  end

  def collaboration_params
    params.require(:collaboration).permit(:ideaboard_id, :user_id)
  end
end
