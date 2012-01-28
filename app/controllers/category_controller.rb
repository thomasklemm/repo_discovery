class CategoryController < ApplicationController
  
  def index
    # Update Category Index
    Category.update_cats
    
    # Show only categories in use
    @cats = Category.where("count > 0").order("total_watchers DESC")
    
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
  
  def create
    input = params[:cat]
    id = input[:id]
    desc = input[:description]
    
    cat = Category.find(id)
    cat.description = desc
    cat.save

    respond_to do |format|
      format.html {redirect_to "/category", notice: "Changes have been saved."}
    end
  end

end
