class GenreController < ApplicationController
  add_breadcrumb I18n.t('home'), :root_path
  add_breadcrumb I18n.t('genres'), :genre_index_path

   def index
     @genres = Genre.all
   end

  def show
    @genre = Genre.friendly.find(params[:id])
    @titles = (@genre.titles.order_by_position - Title.in_removals(current_user)).paginate(page: params[:page], per_page: 30)
    add_breadcrumb @genre.genre_espanol, genre_path(@genre)
    if request.xhr?
       
      render :partial => @titles
    end
  end

end
