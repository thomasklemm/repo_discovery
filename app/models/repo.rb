class Repo < ActiveRecord::Base
  
  validates :owner, :name, presence: true
  
  protected
  
  def self.update_repos
    repos = Repo.all
    github_api_url = "https://api.github.com/repos/"
    
    repos.each do |repo|
      github = JSON.parse(Curl::Easy.perform(github_api_url + repo.owner + "/" + repo.name).body_str)
      %w{name description watchers forks html_url homepage}.each do |field|
        repo[field] = github[field]
      end
      repo["owner"] = github["owner"]["login"]
      repo["last_updated"] = github["updated_at"]
      # Repo speichern
      repo.save
    end
  end
    
end
