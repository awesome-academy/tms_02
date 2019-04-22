module ApplicationHelper
  def full_title page_title
    base_title = I18n.t("title")
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def is_supervisor? user
    current_user.supervisor? && user.id == current_user.id
  end
end
