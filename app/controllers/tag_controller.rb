class TagController < ApplicationController
  
  def create
    repo_id = params[:repo_id]
    tag_name = params[:tag_name].downcase
    
    repo = Repo.find(repo_id)
    repo.category_list << tag_name
    
    if params["remove_tag"]
      repo.category_list.delete(tag_name)
    end
    
    repo.save
    
    respond_to do |format|
      format.html {redirect_to root_url, notice: "Tag successfully added."}
    end

  end

end
