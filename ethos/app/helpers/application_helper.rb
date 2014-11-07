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
end
