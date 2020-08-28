class MessagesController < ApplicationController

  def report
    @title = if params[:title_id]
      Title.find(params[:title_id]).film_title
    end
    @message = Message.new
    render :layout => false
  end

  def create
    Message.create(author: User.find_by_email(params[:message][:author]), message: "USER REPORT A PROBLEM WITH TITLE #{params[:message][:title]} MESSAGE: #{params[:message][:message]}")
    
  end

end
