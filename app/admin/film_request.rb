ActiveAdmin.register FilmRequest do

  permit_params :comment, :film_name, :approximate_year, :user_id

  index do
    column :comment
    column :film_name
    column :approximate_year
    column :user do |item|
      link_to item.user.email, admin_user_path(item.id)
    end
   
    actions
  end

  show do |ad|
    attributes_table do
      
      row :comment
      row :film_name
      row :approximate_year
      row :user do |item|
        link_to item.user.email, admin_user_path(item.id)
      end
      # Will display the image on show object page
    end
  end



end
