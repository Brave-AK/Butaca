# == Schema Information
#
# Table name: countries
#
#  id                :integer          not null, primary key
#  country_code      :string(255)
#  geographic_region :string(255)
#  country           :string(100)
#  active            :boolean
#  is_active?        :boolean
#

class Country < ActiveRecord::Base
  extend FriendlyId
  friendly_id :country, use: :slugged

  has_many :country_titles, :dependent => :destroy
  has_many :titles , :through => :country_titles

end
