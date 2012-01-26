class TagController < ApplicationController
  
  def create
    repo_id = params[:repo_id]
    tag_name = params[:tag_name].downcase
    
    repo = Repo.find(repo_id)
    
    respond_to do |format|
      format.html {
        # find the appropriate tag list
        if params["add_category"]
          repo.category_list << tag_name
          repo.save
          redirect_to :back, notice: "Tagging action succeeded."
        elsif params["remove_category"]
          repo.category_list << tag_name
          repo.category_list.delete(tag_name)
          repo.save
          redirect_to :back, notice: "Tagging action succeeded."
        elsif params["add_framework"]
          repo.framework_list << tag_name
          repo.save
          redirect_to :back, notice: "Tagging action succeeded."          
        elsif params["remove_framework"]
          repo.framework_list << tag_name
          repo.framework_list.delete(tag_name)
          repo.save
          redirect_to :back, notice: "Tagging action succeeded."          
        elsif params["add_language"]
          repo.language_list << tag_name
          repo.save
          redirect_to :back, notice: "Tagging action succeeded."          
        elsif params["remove_language"]
          repo.language_list << tag_name
          repo.language_list.delete(tag_name)
          repo.save
          redirect_to :back, notice: "Tagging action succeeded."          
        else
          #no particular action wish was send along
          redirect_to :back, notice: "Tagging action did not succeed. Was this inteded to be a category, a framework or a language tag?" 
        end
      }
    end

  end

end
