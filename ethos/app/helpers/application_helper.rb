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

  def avatar_profile_link(user, image_options={}, html_options={})
    avatar_url = user.avatar? ? user.avatar.url(:thumb) : 'default_profile.png'
    link_to(image_tag(avatar_url, image_options) + user.context_name(current_user), profile_path(user.username), html_options)
  end
end
