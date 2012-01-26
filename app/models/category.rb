class Category < ActiveRecord::Base
  
  def self.update_cats
    # Load List of all tags (as ActAsTaggableOn Objects)
    # Tag will be accessible via categories.each do |cat| {cat["name"]} 
    cat_tag_hash = Repo.tag_counts_on(:categories)
    
    categories = Hash.new
    cat_tag_hash.each do |cat|
      # Convert Category names to plaintext into a Hash for View
      # Find out how many repos have been tagged with a certain tag by calling Repo.tagged_with("framework").length
      categories[cat["name"]] = Repo.tagged_with(cat["name"], on: :categories).length
    end
    
    # Set count of all categories to 0
    # in order to "remove" unused categories
    # no real removing takes place, in order to preserve descriptions
    Category.all.each do |cat|
      cat.count = 0
      cat.save
    end
    
    # Set current category count numbers
    categories.each do |cat, cat_count|
      category = Category.find_or_initialize_by_name(cat)
      category.count = cat_count
      category.save
    end
    
    
  end
end
