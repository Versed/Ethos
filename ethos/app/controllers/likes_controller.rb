class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :setup_ideaboard
  before_filter :add_breadcrumbs

  def index
    @likes = @ideaboard.likes.all
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)

    if @like.save
      flash[:success] = "You liked #{@ideaboard.title}"
      current_user.create_activity(@ideaboard, 'liked')
      redirect_to(:back)
    else
      flash[:error] = "There was an error. Please try again."
      redirect_to likes_path('ideaboards', @ideaboard)
    end
  end

  def destroy
    @like = @ideaboard.likes.find_by_user_id(current_user.id)

    if @like.destroy
      flash[:success] = "You unliked #{@ideaboard.title}"
      redirect_to(:back)
    else
      flash[:error] = "There was an error. Please try again."
      redirect_to ideaboard_path(@ideaboard)
    end
  end

  private
  def setup_ideaboard
    @ideaboard = Ideaboard.find(params[:id])
    @like = Like.where(:ideaboard_id => @ideaboard.id, :user_id => current_user.id)
  end

  def add_breadcrumbs
    add_breadcrumb "Ideaboards", ideaboards_path
    add_breadcrumb @ideaboard.title, ideaboard_path(@ideaboard)
    add_breadcrumb "Likes"
  end

  def like_params
    params.require(:like).permit(:ideaboard_id, :user_id)
  end
end
