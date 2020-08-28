ActiveAdmin.register Collection do

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

permit_params :locale, :is_featured?, :collection_name, :collection_description_,:_destroy, :featured, :home,:date_time,:user_id,:image,translations_attributes:
 [:locale, :collection_name_, :collection_description_, :id],:playlists_attributes => [:id,:title_id ,:_destroy]

controller do
  def find_resource
    begin
      scoped_collection.where(slug: params[:id]).first!
    rescue ActiveRecord::RecordNotFound
      scoped_collection.find(params[:id])
    end
  end

  def update
    update! do |success, failure|
      success.html do 
        if resource.is_featured?
          Collection.where.not(id: resource.id).update_all(is_featured?: false)  
        end
        redirect_to admin_collections_path  
      end
      
    end
  end
end

form do |f|
  f.inputs "Details" do
    f.input :collection_name
    f.input :collection_description_
    f.input :is_featured?, as: :boolean
    f.input :home
    f.input :user
  end
  f.inputs "Image"  do
    f.input :image, :required => false, :as => :file , :hint => image_tag(f.object.image.url(:thumb))
  end

  f.has_many :playlists ,  new_record: true, :allow_destroy => true do |p|
    p.input :title_id, label: 'Film Title', as: :select, collection: Title.all.order(:film_title).map{|u| ["#{u.film_title}", u.id]}
  end

  f.actions
end





index do
    translation_status
    column :collection_name
    column :collection_description_
    column :featured
    column :home
    column :date_time
    column :user_id
    column :image do |coll|
      link_to image_tag(coll.image.url(:thumb)), "/admin/collections/#{coll.id}"
    end

    actions
end

show do |ad|
  attributes_table do
    row :collection_name
    row :collection_description_
    row :is_featured?
    row :is_home?
    row :date_time
    row :user_id
    row :image do
      image_tag(ad.image.url(:thumb))
    end

    ad.titles.each do |title|
      row :film_title do
         title.film_title
      end
      row :film do
             link_to image_tag(title.key_art.url(:thumb)), "/admin/titles/#{title.id}"
       end
    end

    # Will display the image on show object page
  end
 end

end
