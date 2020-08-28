# == Schema Information
#
# Table name: country_titles
#
#  id         :integer          not null, primary key
#  title_id   :integer
#  country_id :integer
#  params     :text(65535)
#

class CountryTitle < ActiveRecord::Base
  belongs_to :country, counter_cache: :titles_count
  belongs_to :title
  
end
