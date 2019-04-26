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

  def load_subjects_for_selectbox
    @subject = Subject.sort_by_name.map{|s| [s.name, s.id]}
  end
end
