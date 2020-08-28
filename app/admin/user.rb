ActiveAdmin.register User do

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
permit_params :user_id,:email, :password, :password_confirmation,
               :avatar_file_name, :avatar_content_type,
                :avatar_file_size, :avatar_updated_at,:avatar, :name,
                :first_name, :last_name, :bio, :country_id

controller do
  def notify
    count = 0
    User.all.each do |u|
      UserMailer.daily_mail(u).deliver_now
    end
    redirect_to(:back)
  end
end

form do |f|
  f.inputs '' do 
    f.input :email
    f.input :first_name
    f.input :last_name
    f.input :country_id, as: :select, collection: Country.all.map{|c| [c.country, c.id]}
    f.input :bio
    f.input :notification_preferences
    f.input :password
    f.input :password_confirmation
    f.inputs "Avatar", :multipart => true  do
      f.input :avatar, :required => false, :as => :file , :hint => image_tag(f.object.avatar.url(:thumb))

    end
  end  
  f.actions
 end

  index do
    column :email
    column :avatar do |coll|
      link_to image_tag(coll.avatar.url(:thumb)), "/admin/users/#{coll.id}"
    end
    actions
  end


  show do |ad|
    attributes_table do
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :image do
        image_tag(ad.avatar.url(:thumb))
      end
      # Will display the image on show object page
    end
 end

end
