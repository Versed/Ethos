$(document).ready ->
  $("#add-friendship").click (event) ->
    event.preventDefault()
    addFriendshipButton = $(this)
    $.ajax
      url: Routes.user_friendships_path(user_friendship:
        friend_id: addFriendshipButton.data("friendId")
      )
      dataType: "json"
      type: "POST"
      success: (e) ->
        addFriendshipButton.hide()
        $("#friend-status").html "<a href='#' class='button'>Friendship Requested</a>"
        return

    return

  return
