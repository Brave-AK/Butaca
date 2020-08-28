class TitlesController < ApplicationController
  add_breadcrumb I18n.t('home'), :root_path

  def show
    @title = Title.friendly.find(params[:id])
    @country_list = Country.where(is_active?: true)
    @movie_streams = @title.movie_streams.visible
    add_breadcrumb @title.film_title, title_path(@title)
    if request.xhr?
      @modal = true
    end
  end

  def follow
    if current_user
      @title = Title.friendly.find(params[:id])
      if current_user.follow_title?(@title)
        @title.unfollow(current_user)
      else
        @title.follow(current_user)
      end
    end
    respond_to do |format|
      format.js
    end
  end


end
