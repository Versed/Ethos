class TagsController < ApplicationController
  before_filter :add_breadcrumbs

  def index
    params[:page] ||= 1
    @tags = Tag.all.group('name').page(params[:page])
  end

  def show
    add_breadcrumb params[:id]
    tags = Tag.where(name: params[:id])
    @ideaboards = tags.map { |tag| tag.tagable_id if tag.tagable_type == 'ideaboard' }
    @profiles = tags.map { |tag| tag.tagable_id if tag.tagable_type == 'profile' }

    if tags.empty?
      redirect_to tags_path
      flash[:error] = "No tags by that name"
    end
  end

  def create
    @tag = Tag.new
    @tag.name = params[:tag][:name]

    if params[:tag][:ideaboard_id]
      @ideaboard = Ideaboard.find_by_id(params[:tag][:ideaboard_id])
      @tag.tagable_type = 'ideaboard'
      @tag.tagable_id = @ideaboard.id
      tag_parent_path = ideaboard_path(@ideaboard)
    end

    if params[:tag][:profile]
      @profile = User.find_by_id(params[:tag][:profile_id])
      @tag.tagable_type = 'profile'
      @tag.tagable_id = @profile.id
      tag_parent_path = profile_path(@profile)
    end

    if @tag.save
    else
      flash[:error] = "Error, please try again"
    end
    redirect_to tag_parent_path
  end

  def destroy
    @tag = Tag.find_by_name_and_tagable_id(params[:tag_id], params[:id])

    if @tag.destroy
    else
      flash[:error] = "Error. Try again."
    end

    redirect_to(:back)
  end

  private
    def add_breadcrumbs
      add_breadcrumb "Home", ideaboards_path
      add_breadcrumb "Tags", tags_path
    end
end
