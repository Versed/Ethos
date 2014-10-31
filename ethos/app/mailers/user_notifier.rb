class UserNotifier < ActionMailer::Base
  default from: "info@ethos.com"

  def friend_requested(user_friendship_id)
    user_friendship = UserFriendship.find(user_friendship_id)

    @user = user_friendship.user
    @friend = user_friendship.friend

    mail to: @friend.email,
         subject: "#{@user.first_name} wants to be your friend on Ethos"
  end
end
