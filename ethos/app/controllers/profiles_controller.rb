class ProfilesController < ApplicationController
  before_filter :get_user

  def show
    params[:page] ||= 1
    @tag = Tag.new
    @comment = Comment.new

    if @user
      @ideaboards = Ideaboard.where(:user_id => @user.id).paginate(:page => params[:page], :per_page => 4).all
      @user_friendships = @user.friends
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def friends
    params[:page] ||= 1

    if @user
      @user_friendships = @user.friends.page(params[:page])
    end
  end

  private
  def get_user
    @user = User.find_by_username(params[:id])
  end
end
