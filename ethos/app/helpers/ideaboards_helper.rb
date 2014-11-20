module IdeaboardsHelper
  def can_display_ideaboard?(ideaboard)
    signed_in? && !current_user.has_blocked?(ideaboard.user) || !signed_in?
  end

  def can_edit?(ideaboard)
    signed_in? && current_user.id == ideaboard.user.id
  end

  def ideaboard_document_link(status)
    if status.document && status.document.attachment?
      link_to(@ideaboard.document.attachment_file_name, @ideaboard.document.attachment.url)
    end
  end
end
