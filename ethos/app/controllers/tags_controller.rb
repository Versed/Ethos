class TagsController < ApplicationController
  before_filter :add_breadcrumbs

  def index
    params[:page] ||= 1
    @tags = Tag.all.group('name').page(params[:page])
  end

  def show
    params[:page] ||= 1

    add_breadcrumb params[:id]
    ideaboards = Tag.includes(:tagable).where(name: params[:tag_id], tagable_type: "Ideaboard").all
    profiles = Tag.includes(:tagable).where(name: params[:tag_id], tagable_type: "User").all

    @ideaboards = ideaboards.map {|tag| tag.tagable }
    @profiles = profiles.map {|tag| tag.tagable }

    if @ideaboards.empty? && @profiles.empty?
      redirect_to tags_path
      flash[:error] = "No tags by that name"
    end
  end

  def create
    @tag = Tag.new
    @tag.name = params[:tag][:name]

    if params[:tag][:is_skill]
      @tag.is_skill = true
    end

    if params[:tag][:ideaboard_id]
      @ideaboard = Ideaboard.find_by_id(params[:tag][:ideaboard_id])
      @tag.tagable_type = 'Ideaboard'
      @tag.tagable_id = @ideaboard.id
      tag_parent_path = ideaboard_path(@ideaboard)
    end

    if params[:tag][:profile_id]
      @profile = User.find_by_id(params[:tag][:profile_id])
      @tag.tagable_type = 'User'
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
    @tag = Tag.find_by_id(params[:tag_id])

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
