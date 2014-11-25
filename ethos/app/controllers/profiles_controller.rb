class ProfilesController < ApplicationController
  def show
    params[:page] ||= 1
    @user = User.find_by_username(params[:id])
    @tag = Tag.new

    if @user
      @ideaboards = Ideaboard.where(:user_id => @user.id).paginate(:page => params[:page], :per_page => 4).all
      @user_friendships = @user.user_friendships.all
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
end
