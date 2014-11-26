class CollaborationsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :accept]
  before_filter :setup_ideaboard
  before_filter :add_breadcrumbs

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

  def edit
    @collaboration = @ideaboard.collaborations.find_by_id(params[:collaboration_id])
  end

  def accept
    collaboration = @ideaboard.collaborations.find_by_id(params[:collaboration_id])
    if collaboration.accept_collaboration!
      flash[:success] = "Collaborator added."
    else
      flash[:error] = "Could not accept collaboration request."
    end
    redirect_to collaborations_path
  end

  def block
    collaboration = @ideaboard.collaborations.find_by_id(params[:collaboration_id])
    if collaboration.block!
      flash[:success] = "This user has been blocked."
    else
      flash[:error] = "Friendship could not be blocked."
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

  def add_breadcrumbs
    add_breadcrumb "Ideaboards", ideaboards_path
    add_breadcrumb @ideaboard.title, ideaboard_path(@ideaboard)
    add_breadcrumb "Collaborators"
  end
end
