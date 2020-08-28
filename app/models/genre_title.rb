# == Schema Information
#
# Table name: genre_titles
#
#  id       :integer          not null, primary key
#  title_id :integer
#  genre_id :integer
#  params   :text(65535)
#

class  GenreTitle < ActiveRecord::Base
  belongs_to :title
  belongs_to :genre, counter_cache: :titles_count

  
end
