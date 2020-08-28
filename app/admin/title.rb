ActiveAdmin.register Title do
before_filter :paginate
config.sort_order = 'position_asc'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

 permit_params :date_time, :film_title, :year_produced, :snappy_summary, :is_active?, 
              :long_description_espanol,:key_art,:actors,:director, :position,
              :imdb,:internal_comments,:butaca_owned,:short_description_espanol,
              :duration,:film_rating,:active,:meta_verified,:date_updated_can_istream,
              :locale,:country_titles_attributes => [:id,:country_id, :_destroy],
              :genre_titles_attributes => [:id,:genre_id , :_destroy],
              playlists_attributes: [:id, :collection_id]

 #controller do
  #def permitted_params
   # params.require(:title).permit(:id,:date_time, :filmTitle, :yearProduced, :snappySummary,:longDescriptionEspanol,:key_art,:Actors,:Director,:imdb,:internalComments,:butacaOwned,:shortDescriptionEspanol,:duration,:FilmRating,:active,:MetaVerified,:dateUpdatedCanIstream, :locale,:key_art_file_name, :key_art_content_type, :key_art_file_size, :key_art_updated_at,:country_titles_attributes => [:id,:country_id , :_destroy])
  #end
#end
filter :film_title_cont
filter :countries_country_cont, as: :select, collection: -> {Country.all.collect(&:country)}, label: "Country"
filter :genres_genre_espanol_cont, as: :select, collection: -> {Genre.all.collect(&:genre_espanol)}, label: "Genre es"
filter :genres_genre_english_cont, as: :select, collection: -> {Genre.all.collect(&:genre_english)}, label: "Genre en"

action_item :only => :index do
  link_to "all", admin_titles_path(pagination: Title.all.size)
end

collection_action :autocomplete_title_film_title, :method => :get


controller do
  autocomplete :title, :film_title

  def scoped_collection
      super.unscoped
  end
  
  def find_resource
    begin
      scoped_collection.where(slug: params[:id]).first!
    rescue ActiveRecord::RecordNotFound
      scoped_collection.find(params[:id])
    end
  end

  def check_sources
    CheckSourcesJob.perform_later
    redirect_to(:back)
  end

  def paginate
    @per_page = params[:pagination] unless params[:pagination].blank?
  end
end

form do |f|
  f.actions

  f.inputs "Child" do
    f.has_many :country_titles ,  new_record: true,:allow_destroy => true do |p|
      p.input :country_id, label: 'Country', as: :select, collection: Country.all.map{|u| ["#{u.country}", u.id]}
    end

    f.has_many :genre_titles, new_record: true,:allow_destroy => true do |p|
      p.input :genre_id, label: 'Genre', as: :select, collection: Genre.all.map{|u| ["#{u.genre_espanol}", u.id]}
    end

    f.has_many :playlists,  new_record: true, :allow_destroy => true do |p|
      p.input :collection_id, label: 'collection', as: :select, collection: Collection.all.map{|u| ["#{u.collection_name}", u.id]}
    end
  end

  f.inputs "Details" do
    f.input :is_active?
    f.input :position
    f.input :film_title
    f.input :year_produced
    f.input :snappy_summary
    f.input :director
    f.input :actors
  end

  f.inputs "key_art", :multipart => true  do
    f.input :key_art, :required => false, :as => :file , :hint => image_tag(f.object.key_art.url(:thumb))
  end
  f.actions
 end

index do
    sortable_handle_column
    column :position
    column :key_art do |coll|
      link_to image_tag(coll.key_art.url(:thumb)), "/admin/titles/#{coll.id}"
    end
    column :film_title
    column :year_produced
    column :director
    column :collections do |country|
      country.collections.collect(&:collection_name)
    end
    column :country do |country|
      country.countries.collect(&:country)
    end
    column :genre do |genre|
      genre.genres.collect(&:genre_espanol)
    end
    column :snappy_summary_present do |title|
      title.snappy_summary.present? ? status_tag( "yes") : status_tag( "no" )  
    end

    actions
end

show do |ad|
  attributes_table do
    row :key_art do
      image_tag(ad.key_art.url(:thumb))
    end
    row :date_time
    row :film_title
    row :date_updated_can_istream
    row :long_description_espanol
    row :year_produced
    row :snappy_summary
    row :director
    row :film_rating
    row :imdb
    row :short_description_espanol
    row :butaca_owned
    row :actors
    row :duration
    row :is_active?
    row :internal_comments
    row :meta_verified

    ad.genres.each do |genre|
      row :genre do genre.genre_espanol
    end
    end

     ad.countries.each do |country|
      row :country do country.country
     end

    end
    # Will display the image on show object page
  end
 end


  member_action :sort, :method => :post do
    resource.insert_at params[:position].to_i
    head 200
  end


end
