class UserFriendshipsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  before_filter :authenticate_user!, only: [:new]

  def new
    if params[:friend_id]
      @friend = User.where(username: params[:friend_id]).first
      raise ActiveRecord::RecordNotFound if @friend.nil?
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:error] = "Friend required"
    end

  end
  def record_not_found
    render file: 'public/404', status: :not_found
  end
end
