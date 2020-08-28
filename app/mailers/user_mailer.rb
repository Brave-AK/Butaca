class UserMailer < ApplicationMailer

  def daily_mail(user)
     @user = user
     if @user.notification_preferences == 'daily' then
       @notifications = @user.user_log_activities.where("created_at >= ?", Time.zone.now.beginning_of_day)
     elsif @user.notification_preferences == 'weekly'
       @notifications = @user.user_log_activities.where("created_at >= ?", Time.zone.now.beginning_of_week-1.week)
     else
       @notifications = [] 
     end
     mail(to: @user.email, subject: 'Your notifications from butaca')
  end

end
