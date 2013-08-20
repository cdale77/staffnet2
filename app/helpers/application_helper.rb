module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = 'Staffnet'
    if page_title.empty?
      base_title
    else
      "#{base_title}:#{page_title}"
    end
  end

  def correct_user(user)
    user == current_user
  end


  def admin_user?
    current_user.role? :admin
  end
end
