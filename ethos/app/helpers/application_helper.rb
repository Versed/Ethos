module ApplicationHelper
  def flash_class(type)
    case type
    when "alert"
      "alert"
    when "notice"
      "info"
    else
      ""
    end
  end

  def can_display_ideaboard?(ideaboard)
    signed_in? && !current_user.has_blocked?(ideaboard.user) || !signed_in?
  end

  def ideaboard_document_link(status)
    if status.document && status.document.attachment?
      link_to(@ideaboard.document.attachment_file_name, @ideaboard.document.attachment.url)
    end
  end

  def avatar_profile_link(user, image_options={}, html_options={})
    avatar_url = user.avatar? ? user.avatar.url(:thumb) : nil
    link_to(image_tag(avatar_url, image_options), profile_path(user.profile_name))
  end
end
