module RepoHelper
  
  # View Helper
  def time_ago_in_less_precise_words(last_updated)
    # less precise than time_ago_in_words()
    td = Time.now - last_updated
    
    if td < (61*60)
      return "1 hour"
    elsif td < (121*60)
      return "2 hours"
    elsif td < (24*60*60)
      return "24 hours"
    elsif td < (3*24*60*60)
      return "3 days"
    elsif td < (7*24*60*60)
      return "1 week"
    elsif td < (14*24*60*60)
      return "2 weeks"
    elsif td < (31*24*60*60)
      return "1 month"
    elsif td < (62*24*60*60)
      return "2 months"
    elsif td < (93*24*60*60)
      return "3 months"
    elsif td < (183*24*60*60)
      return "6 months"  
    elsif td < (365*24*60*60)
      return "1 year"
    elsif td < (2*365*24*60*60)
      return "2 years"
    elsif td < (3*365*24*60*60)
      return "3 years"
    elsif td < (5*365*24*60*60)
      return "5 years"      
    elsif td < (10*365*24*60*60)
      return "1 decade"
    elsif td > (10*365*24*60*60)
      return "1 century"
    else
    end
  end
  
  # View Helper
  def activity_light(last_updated)
    time_difference = Time.now - last_updated
    
    if time_difference < (18*24*60*60)
      return "activity awesomely_active"
    elsif time_difference < (38*24*60*60)
      return "activity greatly_active"
    elsif time_difference < (93*24*60*60)
      return "activity active"
    elsif time_difference < (185*24*60*60)
      return "activity less_active"
    elsif time_difference > (185*24*60*60)
      return "activity not_active"
    end
  end
  
end
