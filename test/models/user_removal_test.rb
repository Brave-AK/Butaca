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

require 'test_helper'

class UserRemovalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
