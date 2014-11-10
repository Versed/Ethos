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
    html = ""

    if status.document && status.document.attachment?
      html << link_to(@ideaboard.document.attachment_file_name, @ideaboard.document.attachment.url)
      return html.html_safe
    end
  end
end
