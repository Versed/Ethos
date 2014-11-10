class IdeaboardsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @ideaboards = Ideaboard.order('created_at desc').all
  end

  def show
    @ideaboard = Ideaboard.find(params[:id])
  end

  def new
    @ideaboard = current_user.ideaboards.new
    @ideaboard.build_document
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
    @document = @ideaboard.document

    if params[:ideaboard] && params[:ideaboard].has_key?(:user_id)
      params[:ideaboard].delete(:user_id)
    end

    if @ideaboard.update_attributes(ideaboard_params) && @document &&
        @document.update_attributes(params[:ideaboard][:documents_attributes])
      redirect_to @ideaboard
    else
      render 'edit'
    end
  end

  def ideaboard_params
    params.require(:ideaboard).permit(:title, :description, documents_attributes: [:attachment, :remove_attachment])
  end
end
