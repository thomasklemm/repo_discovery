class Category < ActiveRecord::Base
  
  def self.update_cats
    # Load List of all tags (as ActAsTaggableOn Objects)
    # Tag will be accessible via categories.each do |cat| {cat["name"]} 
    cat_tag_hash = Repo.tag_counts_on(:categories)
    
    categories = Hash.new
    cat_tag_hash.each do |cat|
      # Convert Category names to plaintext into a Hash for View
      # Find out how many repos have been tagged with a certain tag by calling Repo.tagged_with("framework").length
      repos = Repo.tagged_with(cat["name"], on: :categories)
      cat_stats = Hash.new
      cat_stats["count"] = repos.length
      
      # Find out the total watchers for every category
      total_watchers = 0
      repos.each do |repo|
        total_watchers += repo.watchers
      end
      cat_stats["total_watchers"] = total_watchers
      
      categories[cat["name"]] = cat_stats
    end
    
    # Set count of all categories to 0
    # in order to "remove" unused categories
    # no real removing takes place, in order to preserve descriptions
    Category.all.each do |cat|
      cat.count = 0
      cat.save
    end
    
    # Set current category count numbers
    categories.each do |cat, cat_stats|
      category = Category.find_or_initialize_by_name(cat)
      category.count = cat_stats["count"]
      category.total_watchers = cat_stats["total_watchers"]
      category.save
    end
    
    
  end
end
