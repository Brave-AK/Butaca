namespace :butaca do
  desc "Check sources for titles"
  task :check_sources => :environment do
    client = Canistreamit::Client.new
    Title.all.each {|t| t.check_sources(client)}
  end
end
