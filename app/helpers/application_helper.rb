module ApplicationHelper
  
  def day_name_today
    t = Time.now
    return t.strftime("%A")
  end
  
  def is_active?(cont_name)
    c = controller.controller_name
    if c == cont_name
      return "active"
    else
    end
  end
  
end
