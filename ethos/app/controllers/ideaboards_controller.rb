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
    @ideaboard = current_user.ideaboards.new(ideaboard_params)

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
    @ideaboard = current_user.ideaboards.find(ideaboard_params)
    if params[:ideaboard] && params[:ideaboard].has_key?(:user_id)
      params[:ideaboard].delete(:user_id)
    end

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
