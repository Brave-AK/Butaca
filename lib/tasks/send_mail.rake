namespace :butaca do
  desc "Send daily email"
  task :daily_mail => :environment do
    User.all.each do |u|
      if u.notification_preferences == "weekly" && Date.today.strftime("%A") == "Monday" then
        UserMailer.daily_mail(u).deliver_now
      elsif u.notification_preferences == "daily" then
        UserMailer.daily_mail(u).deliver_now
      else
        puts "User #{u.email} doesnt want to catch notifications right now"
      end
    end
  end
end
