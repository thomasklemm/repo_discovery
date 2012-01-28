module CategoryHelper
  
  def size_helper(text)
    if text
      return text.length + 50
    else
      return 70 
    end
  end
  
end
