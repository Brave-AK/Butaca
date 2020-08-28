# == Schema Information
#
# Table name: playlists
#
#  id            :integer          not null, primary key
#  date_time     :datetime
#  collection_id :integer
#  title_id      :integer
#

class Playlist < ActiveRecord::Base

  belongs_to :collection, counter_cache: :titles_count
  belongs_to :title
  after_create :notify

  protected

  def notify(*args)
    self.collection.notifications.each {|n| n.notify("#{self.title.film_title} #{I18n.t('added_to_collection')} #{self.collection.collection_name}")}
  end

end
