class RepoController < ApplicationController
  
  # GET /repo
  def index
    @repos = Repo.order("watchers DESC")
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /repo/1
  def show
    if params[:id]
      @repo = Repo.find_by_id(params[:id])
      note = params[:id].to_s
    elsif (params[:owner] and params[:name])
      @repo = Repo.find_by_owner_and_name(params[:owner].strip, params[:name].strip)
      note = params[:owner].strip + "/" + params[:name].strip
    end
    
    unless @repo.nil?
      @alternatives = @repo.find_related_categories
    end
    
    respond_to do |format|
      format.html {
        if @repo.nil?
          redirect_to :root, notice: "Repo '#{note}' not found."
        else
          # show.html.erb
        end
        }
    end
  end

  # GET /repo/new
  def new
    @repo = Repo.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /repo/1/edit
  def edit
    @repo = Repo.find(params[:id])
  end
  
    # POST /repo
  def create
    # Create an empty repo in memory
    repo = Repo.new
    
    # Var. 1) Github Repo posted to "/addrepo?url="
    if params[:url]
      url = params[:url]
      # Strip url of leading or trailing whitespace
      # Gsub part of url that is not nescessary
      ident = url.gsub("https://github.com/", "").strip
    
      # Split repo ident
      repo.owner = ident.split("/")[0]
      repo.name = ident.split("/")[1]
      repo.ident = ident
    end
  
    # Var. 2) Github Repo is being added by posting to "/repo" through form
    if params[:repo]
      # Remove leading and trialing whitespace
      repo.owner = params[:repo][:owner].strip
      repo.name = params[:repo][:name].strip
      repo.ident = repo.owner + "/" + repo.name
    end
    
    respond_to do |format|
      if Repo.find_by_ident(repo.ident).nil?
        # Repo is not yet listed
        
        if repo.save # check validation
        
          # Validations passed
          if Repo.init_repo(repo.id)
            # Repo could be found on Github
            format.html { redirect_to "/repo/#{repo.id}", notice: ":-) The repo '#{repo.owner}/#{repo.name}' has been successfully added. Thanks for helping to improve this site!" }
          else
            # Repo could not be found on Github and was deleted
            format.html { redirect_to root_url, notice: "The repo '#{repo.owner}/#{repo.name} could not be found on Github. Please try again."}
          end
        
        else
          # Validation failed
          format.html { redirect_to root_url, notice: "Error. Please provide the repo owner and name on Github once again." }
        end
        
      else
        # Repo already listed  
        format.html { redirect_to "/repo/#{repo.id}", notice: "Error. The repo '#{repo.owner}/#{repo.name}' is already listed. Maybe you'd like to tag it! Thanks for your help!"}
      end
      
    end
    
  end # create

  # PUT /repo/1
  def update
    @repo = Repo.find(params[:id])

    respond_to do |format|
      if @repo.update_attributes(params[:repo])
        format.html { redirect_to @repo, notice: 'Repo was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /repo/1
  def destroy
    @repo = Repo.find(params[:id])
    @repo.destroy

    respond_to do |format|
      format.html { redirect_to repos_url }
    end
  end

end

