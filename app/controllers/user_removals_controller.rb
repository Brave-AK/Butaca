class UserRemovalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_removals = current_user.user_removals
  end

  def add
    if current_user then
      @user_removal = UserRemoval.where(user_id: current_user.id, title_id: params[:title_id])
      if @user_removal.any? then
        @user_removal.first.destroy
        notice = "Title removed from removals"
      else
        UserRemoval.create(user: current_user, title_id: params[:title_id])
        notice = "Title added to removals"
      end
      respond_to do |format|
        format.js
        format.html {redirect_to(:back, :notice => notice) }
      end
    else
      respond_to do |format|
        format.js do
          flash[:notice] = 'Para guardar tus películas favoritas tienes que ingresar o registrarte aquí.Te prometemos que no te enviaremos spam y tu cuenta estará creada en menos que canta un gallo.'
          render('shared/render_alert')
        end
      end
    end
  end

end
