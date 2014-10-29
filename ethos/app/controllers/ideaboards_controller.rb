class IdeaboardsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @ideaboards = Ideaboard.all
  end

  def show
    @ideaboard = Ideaboard.find(params[:id])
  end

  def new
    @ideaboard = Ideaboard.new
  end

  def create
    @ideaboard = current_user.ideaboards.build(ideaboard_params)

    if @ideaboard.save
      redirect_to @ideaboard
    else
      render 'new'
    end
  end

  def ideaboard_params
    params.require(:ideaboard).permit(:title, :description)
  end
end
