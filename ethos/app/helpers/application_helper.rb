module ApplicationHelper
  def foundation_paperclip_picture(form, paperclip_object)
    if form.object.send("#{paperclip_object}?")
      content_tag(:div, class: '') do
        content_tag(:label, "Current #{paperclip_object}.to_s.titleize", class: '') +
        content_tag(:div, class: '') do
          image_tag form.object.send(paperclip_object).send(:url, :small)
        end
      end
    end
  end

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
    link_to(image_tag(avatar_url, image_options), profile_path(user.username))
  end
end
