module CategoryHelper
  
  def size_helper(text)
    if text
      return text.length + 50
    else
      return 70 
    end
  end
  
  def print_top_repos_for_category(cat_name)
    repos = Repo.tagged_with(cat_name, on: :categories).order("watchers DESC")
    top_repos = Array.new
    repos.each do |repo|
      top_repos << repo.name
    end
    
    return top_repos.join(", ")
  end
  
end
