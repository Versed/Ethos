class IdeaboardsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]

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

  def edit
    @ideaboard = Ideaboard.find(params[:id])
  end

  def update
    if @ideaboard.update(ideaboard_params)
      redirect_to @ideaboard
    else
      render 'edit'
    end
  end

  def ideaboard_params
    params.require(:ideaboard).permit(:title, :description)
  end
end
