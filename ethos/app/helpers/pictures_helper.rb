module PicturesHelper
  def can_edit_picture?(picture)
    signed_in? && current == picture.user
  end
end
