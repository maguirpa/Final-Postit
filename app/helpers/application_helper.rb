module ApplicationHelper

  def display_time(dt)
    dt.strftime("%B %e, %Y at %l:%M %p")
  end

end
