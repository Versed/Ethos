class IdeaboardsController < ApplicationController
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
    @ideaboard = Ideaboard.new(ideaboard_params)

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
