require "snake_case"
class MovieStreamLinkType < ActiveRecord::Base
  has_many :movie_stream
  after_create :update_transaction_type

  has_attached_file :logo, :styles => { :medium => "x24>" }, :default_url => "/noimage/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  has_attached_file :small_logo, :styles => { :tiny => "x24" }, :default_url => "/noimage/:style/missing.png"
  validates_attachment_content_type :small_logo, :content_type => /\Aimage\/.*\Z/

  ["Free", "Digital Purchase", "Rental", "Subscription"].each do |t|
    scope t.snakecase.to_sym, -> { where(transaction_type: t) }
  end

  def update_transaction_type
    if typel.include?("free") then
      self.update_attribute(:transaction_type, "Free")
    elsif typel.include?("dvd") || typel.include?("bluray") || typel.include?("purchase")
      self.update_attribute(:transaction_type, "Digital Purchase")
    elsif typel.include?("rental")
      self.update_attribute(:transaction_type, "Rental")
    else
      Message.create(message: "CANNOT RECOGNIZE A TRANSACTION TYPE FOR #{self.typel}. SET IT MANUALY")
    end
  end

end
