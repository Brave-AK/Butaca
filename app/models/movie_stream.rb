require "snake_case"
# == Schema Information
#
# Table name: movie_streams
#
#  id          :integer          not null, primary key
#  typel       :string(255)
#  link        :string(255)
#  link_type   :string(255)
#  price       :decimal(10, 2)
#  title_id    :integer          not null
#  external_id :string(255)      default(""), not null
#  logo        :text(65535)
#

class MovieStream < ActiveRecord::Base

  belongs_to :title
  belongs_to :movie_stream_link_type
  after_create :notify

  ["Free", "Digital Purchase", "Rental", "Subscription"].each do |t|
    scope t.snakecase.to_sym, -> { joins(:movie_stream_link_type).where("movie_stream_link_types.transaction_type = ?", t) }
  end

  scope :visible, -> {joins(:movie_stream_link_type).where("movie_stream_link_types.visible = true")}

  protected

  # def notify(*args)
  #   self.title.notifications.each {|n| n.notify("#{self.title.film_title} #{I18n.t('is_now_available')} #{self.movie_stream_link_type.typel.try(:humanize)}")}
  # end

end
