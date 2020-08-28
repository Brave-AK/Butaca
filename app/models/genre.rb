# == Schema Information
#
# Table name: genres
#
#  id            :integer          not null, primary key
#  date_time     :datetime
#  genre_english :string(255)
#  genre_espanol :string(255)
#  active        :boolean
#  is_active?    :boolean
#

class Genre < ActiveRecord::Base
  extend FriendlyId
  friendly_id :genre_espanol, use: :slugged
  
  has_many :genre_titles, :dependent => :destroy
  has_many :titles, :through => :genre_titles




end
