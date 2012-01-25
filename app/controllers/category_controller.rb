class CategoryController < ApplicationController
  
  def index
    categories = Repo.tag_counts_on("categories")
    
    @categories = Hash.new
    
    categories.each do |category| 
      @categories[category["name"]] = Repo.tagged_with(category["name"]).length
    end
    
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
