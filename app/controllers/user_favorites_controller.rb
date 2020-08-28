class UserFavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @user_favorites = current_user.user_favorites
  end

  def add
    if current_user then
      @user_favorites = UserFavorite.where(user_id: current_user.id, title_id: params[:title_id])
      if @user_favorites.any? then
        @user_favorites.first.destroy
        notice = "Title removed from favorites"
      else
        UserFavorite.create(user: current_user, title_id: params[:title_id])
        notice = "Title added to favorites"
      end
      respond_to do |format|
        format.js
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
