# == Schema Information
#
# Table name: user_removals
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserRemoval < ActiveRecord::Base
  validates :user_id, uniqueness: { scope: :title_id }

  belongs_to :user
  belongs_to :title
end
