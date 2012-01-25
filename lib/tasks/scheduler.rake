desc "This task is called by the Heroku scheduler add-on"

task :update_repos => :production do
  Repo.update_repos
end