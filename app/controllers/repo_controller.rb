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
        format.html { redirect_to root_url, notice: ":-) The repo '#{repo.owner}/#{repo.name}' has been successfully added. Thanks for helping to improve this site!" }
      else
        format.html { redirect_to root_url, notice: ":-( The repo '#{repo.owner}/#{repo.name}' could not be found on Github. Please try again." }
      end
    end
    
  end

end
