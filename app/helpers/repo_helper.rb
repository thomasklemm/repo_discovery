module RepoHelper
  
  # time_ago_in_words(time) as view helper possible
  
  def activity_light(last_updated)
    time_difference = Time.now - last_updated
    
    if time_difference < (18*24*60*60)
      return "activity awesomely_active"
    elsif time_difference < (38*24*60*60)
      return "activity greatly_active"
    elsif time_difference < (92*24*60*60)
      return "activity active"
    elsif time_difference < (185*24*60*60)
      return "activity less_active"
    elsif time_difference > (185*24*60*60)
      return "activity not_active"
    end
    
  end
  
end
