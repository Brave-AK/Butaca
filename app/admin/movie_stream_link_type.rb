ActiveAdmin.register MovieStreamLinkType do
permit_params :typel, :logo, :transaction_type, :small_logo
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :typel, :transaction_type, :visible, :logo, :small_logo
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
form do |f|
  f.inputs "Details" do
    f.input :typel
    f.input :transaction_type, as: :select, collection: ["Free", "Digital Purchase", "Rental", "Subscription"]
    f.input :visible
  end
  f.inputs "Logo", :multipart => true  do
    f.input :logo, :required => false, :as => :file , :hint => image_tag(f.object.logo.url(:medium))
  end
  f.inputs "Small Logo", :multipart => true  do
    f.input :small_logo, :required => false, :as => :file , :hint => image_tag(f.object.small_logo.url(:tiny))
  end
  f.actions
 end


end
