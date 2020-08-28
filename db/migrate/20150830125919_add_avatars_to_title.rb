class AddAvatarsToTitle < ActiveRecord::Migration
  def self.up
    change_table :titles do |t|
      t.attachment :key_art
    end
  end

  def self.down
    drop_attached_file :titles, :key_art
  end
end
