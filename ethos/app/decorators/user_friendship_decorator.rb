class UserFriendshipDecorator < Draper::Decorator
  delegate_all

  def friendship_state
    model.state.titleize
  end

  def sub_message
    case model.state
    when 'pending'
      "Friend request is pending."
    when 'accepted'
       "You are friends with #{model.friend.first_name}."
    end
  end
end
