ActiveAdmin.register CollectionTranslation do

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
filter :collection, as: :select, collection: -> {Collection.all.map{|col| [col.collection_name, col.id] }}
filter :locale
filter :created_at
filter :updated_at
filter :collection_name
filter :collection_description_

permit_params :collection_name, :collection_description_, :locale, :collection_id

form do |f|
  f.inputs "Details" do
    f.input :locale, as: :select, collection: ['es', 'en']
    f.input :collection_name
    f.input :collection_description_
    f.input :collection_id, as: :select, collection: Collection.all.order(:collection_name).map{|u| ["#{u.collection_name}", u.id]}
  end
  f.actions
end


end
