class TagsController < ApplicationController
  before_filter :add_breadcrumbs

  def index
    params[:page] ||= 1
    @tags = Tag.all.group('name').page(params[:page])
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
    add_breadcrumb params[:id]
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

    def add_breadcrumbs
      add_breadcrumb "Home", ideaboards_path
      add_breadcrumb "Tags", tags_path
    end
end
