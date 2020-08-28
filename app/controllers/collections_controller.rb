class CollectionsController < ApplicationController
  add_breadcrumb I18n.t('home'), :root_path
  add_breadcrumb I18n.t('collections'), :collections_path

  # GET /collections
  def index
    @collections = Collection.all.paginate(page: params[:page], per_page: 3)
    if request.xhr?

      render :partial => @collections
    end
  end

  # GET /collections/1
  def show
    @collection = Collection.friendly.find(params[:id])
    @titles = (@collection.titles.order_by_position-Title.in_removals(current_user)).paginate(page: params[:page], per_page: 30)
    add_breadcrumb @collection.collection_name, collection_path(@collection)
    if request.xhr?

      render :partial => @titles
    end
  end


  def follow
    if current_user
      @collection = Collection.friendly.find(params[:id])
      if @collection.followers.where(id: current_user.id).any? then
        @collection.unfollow(current_user)
      else
        @collection.follow(current_user)
      end
    end
    @template = render_to_string(partial: 'follow_button', locals: {collection: @collection})
    respond_to do |format|
      format.js
    end
  end





end
