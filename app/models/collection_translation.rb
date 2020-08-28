# == Schema Information
#
# Table name: collection_translations
#
#  id                      :integer          not null, primary key
#  collection_id           :integer          not null
#  locale                  :string(255)      not null
#  created_at              :datetime
#  updated_at              :datetime
#  collection_name         :string(255)
#  collection_description_ :text(65535)
#

class CollectionTranslation < ActiveRecord::Base
  belongs_to :collection

end
