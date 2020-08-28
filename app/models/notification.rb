class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifier, polymorphic: true
  has_one :user_log_activity

  def notify(message)
    UserLogActivity.create(message: message, user: self.user, notification: self)
  end

end
