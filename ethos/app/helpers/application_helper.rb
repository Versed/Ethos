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
end
