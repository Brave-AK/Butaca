require 'server_side'
class UserActivityLogsController < ApplicationController
  include ActionController::Live

  def mark_as_readed
    @notification = UserLogActivity.find params[:notification]
    @notification.update_attribute(:readed, true)
    respond_to do |format|
      format.js
    end
  end

  def mark_all_as_readed
    @notifications = current_user.user_log_activities
    @notifications.each {|n| n.update_attribute(:readed, true)}
    respond_to do |format|
      format.js {render 'mark_as_readed'}
    end
  end

  #def send_message
  #  response.headers['Content-Type'] = 'text/event-stream'
  #  redis = Redis.new
  #  redis.subscribe('crier:transitions') do |on|
  #    on.message do |event, data|
  #      response.stream.write "data: #{JSON.dump(data)}"
  #      response.stream.write "\n\n"
  #    end
  #  end
  #rescue IOError
  #  logger.info "Stream closed"
  #ensure
  #  redis.quit
  #  response.stream.close
  #end

end
