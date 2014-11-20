class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def create
    @ideaboard = Ideaboard.find_by_id(params[:id])
    @tag = @ideaboard.tags.new(tag_params)

    if @tag.save
    else
      flash[:error] = "Error, please try again"
    end
    redirect_to ideaboard_path(@ideaboard)
  end

  def show
    tags = Tag.where(name: params[:id])
    @ideaboards = tags.map { |tag| tag.ideaboard }

    if tags.empty?
      redirect_to tags_path
      flash[:error] = "No tags by that name"
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:ideaboard_id, :name)
  end
end
