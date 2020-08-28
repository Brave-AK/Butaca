# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :collections
  has_and_belongs_to_many :followed_collections, class_name: "Collection", :uniq => true
  has_many :notifications
  has_many :user_favorites
  has_many :user_removals
  has_many :user_queues
  has_many :user_log_activities
  has_many :messages, as: :author
  has_many :messages, as: :receiver
  has_many :film_requests
  belongs_to :country

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/noimage/empty_avatar.svg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  ratyrate_rater

  def username
    name || email
  end

  def follow_collection?(collection_id)
    followed_collection_ids.include?(collection_id)
  end

  def favorited_title?(title)
    UserFavorite.where(user_id: id, title_id: title.id).present?
  end

  def queued_title?(title)
    UserQueue.where(user_id: id, title_id: title.id).present?
  end

  def follow_title?(title)
    title.notifications.where(user: self).present?
  end


end
