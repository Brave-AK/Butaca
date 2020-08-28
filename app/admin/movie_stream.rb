ActiveAdmin.register MovieStream do
  permit_params :title_id, :typel, :link, :link_type, :price, :logo, :movie_stream_link_type_id, :protect

  filter :title_film_title_eq, :as => :autocomplete, :url => '/admin/titles/autocomplete_title_film_title',
                        :label => "Title", :required => false,
                        :wrapper_html => { :style => "list-style: none" }
  filter :movie_stream_link_type
  filter :typel
  filter :link
  filter :price
  filter :logo
  filter :protect                        


  form do |f|
    inputs 'Details' do
      f.input :title_id, as: :hidden, input_html: {id: 'title-id-input'}
      f.input :title, as: :autocomplete, input_html: {id: "stream-title-id", value: f.object.try(:title).try(:film_title), id_element: '#title-id-input'},
              url: autocomplete_title_film_title_admin_titles_path,
              member_label: :film_title

      f.input :typel, as: :select, collection: ['dvd', 'rental', 'purchase', 'streaming']
      f.input :link
      f.input :movie_stream_link_type, as: :select, collection: MovieStreamLinkType.all.map{|u| ["#{u.typel}", u.id]}
      f.input :price
      f.input :protect
      f.actions
    end
  end



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


end
