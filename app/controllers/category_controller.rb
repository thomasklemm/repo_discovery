class CategoryController < ApplicationController
  
  def index
    # Load List of all tags (as ActAsTaggableOn Objects)
    # Tag will be accessible via categories.each do |cat| {cat["name"]} 
    categories = Repo.tag_counts_on(:categories)
    
    @categories = Hash.new
    categories.each do |category|
      # Convert Category names to plaintext into a Hash for View
      # Find out how many repos have been tagged with a certain tag by calling Repo.tagged_with("framework").length
      @categories[category["name"]] = Repo.tagged_with(category["name"], on: :categories).order("watchers DESC")
    end
    
    @categories.sort { |a, b| -1* (a[1].length <=> b[1].length)}
    
    respond_to do |format|
      format.html #index.html.erb
    end  
  end
  
  
  def show
    @cat_name = params[:id]
    @repos = Repo.tagged_with(@cat_name).order("watchers DESC")
    
    respond_to do |format|
      format.html #show.html.erb
    end
  end

end
