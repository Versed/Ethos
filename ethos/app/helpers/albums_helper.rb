module AlbumsHelper
  def album_thumbnail(album)
    if album.pictures.count > 0
      image_tag(album.pictures.first.asset.url(:small))
    else
      image_tag("placeholder.todo")
    end
  end

  def can_edit_album?(album)
    signed_in? && current_user.id == album.ideaboard.user_id
  end
end
