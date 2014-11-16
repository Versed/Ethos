class CollaborationsController < ApplicationController
  before_filter :setup_ideaboard

  def index
    @collaborations = @ideaboard.collaborations.all
  end

  def new
    @collaboration = @ideaboard.collaborations.new
  end

  def create
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
    @ideaboard = Ideaboard.find(params[:id])
  end

  def collaboration_params
    params.require(:collaboration).permit(:ideaboard_id, :user_id)
  end
end
