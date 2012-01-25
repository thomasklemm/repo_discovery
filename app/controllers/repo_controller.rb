class RepoController < ApplicationController
  def index
    @repos = Repo.order("watchers DESC")
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def create
    repo = Repo.new(params[:repo])
    
    respond_to do |format|
      if repo.save
        # Validations passed
        Repo.init_repo(repo.id)
        format.html { redirect_to root_url, notice: ":-) The repo '#{repo.owner}/#{repo.name}' has been successfully added. Thanks for helping to improve this site!" }
      else
        # Validation failed
        format.html { redirect_to root_url, notice: "Error. Please provide the repo owner and name on Github once again." }
      end
    end
    
  end

end
