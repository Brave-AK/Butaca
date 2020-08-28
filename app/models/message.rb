class Message < ActiveRecord::Base
  belongs_to :author, polymorphic: true
  belongs_to :receiver, polymorphic: true

end
