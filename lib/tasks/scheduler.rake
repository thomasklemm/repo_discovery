desc "This task is called by the Heroku scheduler add-on"

task :update_repos => :production do
  puts "Updating repos..."
  Repo.update_repos
  puts "Done updating repos."
end