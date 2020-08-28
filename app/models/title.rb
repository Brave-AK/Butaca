# == Schema Information
#
# Table name: titles
#
#  id                        :integer          not null, primary key
#  date_time                 :datetime
#  film_title                :string(255)
#  year_produced             :string(255)
#  snappy_summary            :text(65535)
#  long_description_espanol  :text(65535)
#  key_art                   :text(65535)
#  actors                    :text(65535)
#  director                  :string(255)
#  imdb                      :text(65535)
#  internal_comments         :string(255)
#  butaca_owned              :text(65535)
#  short_description_espanol :text(65535)
#  duration                  :string(255)
#  film_rating               :string(255)
#  active                    :boolean
#  meta_verified             :integer
#  date_updated_can_istream  :datetime
#  key_art_file_name         :string(255)
#  key_art_content_type      :string(255)
#  key_art_file_size         :integer
#  key_art_updated_at        :datetime
#  is_active?                :boolean
#

class Title < ActiveRecord::Base
  extend FriendlyId

  # Only films marked as active by admin should be visible for users
  default_scope { where(is_active?: true) }

  friendly_id :film_title, use: :slugged
  ratyrate_rateable "users_score"
  acts_as_list

  #belongs_to :collection
  has_attached_file :key_art, :styles => { :medium => "300x300>", :thumb => "50x50#", :custom => "694x1000#"}, :default_url => "/noimage/:style/missing.png"
  validates_attachment_content_type :key_art, :content_type => /\Aimage\/.*\Z/
  has_many :movie_streams, after_add: :notify
  has_many :notifications, as: :notifier
  has_many :country_titles, :dependent => :destroy
  has_many :countries , :through => :country_titles

  has_many :genre_titles, :dependent => :destroy
  has_many :genres , :through => :genre_titles

  has_many :playlists, :dependent => :destroy
  has_many :collections, :through => :playlists
  has_many :platform_update_logs

  has_many :user_favorites
  has_many :user_removals
  has_many :user_queues
  accepts_nested_attributes_for :country_titles, :allow_destroy => true
  accepts_nested_attributes_for :genre_titles, :allow_destroy => true
  accepts_nested_attributes_for :playlists, :allow_destroy => true

  validates :film_title, presence: true

  scope :order_by_position, -> {order('position asc')}


  def self.in_removals(user)
    if user then
      includes(:user_removals).where(:user_removals => {user_id: user.id})
    else
      return []
    end
  end

  def follow(user)
    self.notifications.build(user: user)
    save!
  end

  def unfollow(user)
    self.notifications.where(user: user).first.destroy
    save!
  end

  def check_sources(client)
    sources_list = []
    response = client.search_and_query(self.film_title, ['streaming', 'rental', 'purchase', 'dvd', 'xfinity']).first
    if response
      ['streaming', 'rental', 'purchase', 'dvd', 'xfinity'].each do |type|
        response["availability"][type].each do |source|
          if source.first != "amazon_bluray" then
            if source.first != "netflix_dvd" then
              stream_type = MovieStreamLinkType.find_by_typel(source.first)
              if stream_type == nil then
                stream_type = MovieStreamLinkType.create(typel: source.first)
                Message.create(message: "NEW STREAM TYPE #{stream_type.typel} ADDED. PLEASE, ADD A LOGO MANUALY")
              end
              if source.last["direct_url"]
                url = source.last["direct_url"]
              else
                url = source.last['url']
              end
              params = {link: url, typel: type, movie_stream_link_type: stream_type, price: source.last["price"], external_id: source.last["external_id"] || 0}
              stream = self.movie_streams.find_by(params)
              if stream then
                sources_list << stream
              else
                sources_list << self.movie_streams.create(params)
                PlatformUpdateLog.create(title: self, body: "(#{Time.now}) New platform #{stream_type.typel} added for title #{self.film_title}")
              end
            end
          end
        end
      end
      not_longer_present_list = self.movie_streams - sources_list
      not_longer_present_list.each {|m| m.destroy unless m.protect == true}
    end
  end

  def image
    key_art
  end

  protected

  def notify(*args)
    new_platform = args[0]
    self.notifications.each {|n| n.notify("#{film_title} #{I18n.t('is_now_available')} #{new_platform.movie_stream_link_type.typel.try(:humanize)}")}
  end

end
