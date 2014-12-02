class CommentsController < ApplicationController
  before_filter :set_comment

  def show
  end

  def create
    aewfaewfawefawefaw
    @comment = Comment.new
    @comment.title = params[:comment][:title]
    @comment.comment = params[:comment][:comment]
    @comment.user_id = params[:comment][:user_id]
    path = set_target

    if @comment.save
    else
      flash[:error] = "Error, please try again"
    end
    redirect_to path
  end

  private
  def set_comment
    @comment = Comment.find_by_id(params[:id])
  end

  def add_breadcrumbs
    add_breadcrumb @comment.commentable_type, parent_path
    add_breadcrumb @comment.title
  end

  def parent_path
    case @comment.commentable_type
    when 'User'
      profile_path(@comment.commentable_id)
    when 'Picture'
    when 'Album'
    else
      ideaboards_path
    end
  end

  def set_target
    if params[:comment][:profile_id]
      @profile = User.find_by_id(params[:comment][:profile_id])
      @comment.commentable_type = 'User'
      @comment.commentable_id = @profile.id
      comment_parent_path = profiles_path(@profile)
    end

    if params[:comment][:ideaboard_id]
      @ideaboard = Ideaboard.find_by_id(params[:comment][:ideaboard_id])
      @comment.commentable_type = 'Ideaboard'
      @comment.commentable_id = @ideaboard.id
      comment_parent_path = ideaboard_path(@ideaboard)
    end

    if params[:comment][:album_id]
      @album = Album.find_by_id(params[:comment][:album_id])
      @comment.commentable_type = 'Album'
      @comment.commentable_id = @album.id
      comment_parent_path = album_path(@album)
    end

    if params[:comment][:picture_id]
      @picture = Picture.find_by_id(params[:comment][:picture_id])
      @comment.commentable_type = 'Picture'
      @comment.commentable_id = @picture.id
      comment_parent_path = picture_path(@picture)
    end

    comment_parent_path
  end
end
