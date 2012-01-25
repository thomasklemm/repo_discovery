desc "This task is called by the Heroku scheduler add-on"

task :update_repos => :production do
  puts "Updating repos..."
  rails runner Repo.update_repos
  puts "Done updating repos."
end