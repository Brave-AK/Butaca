class AddAttachmentSmallLogoToMovieStreamLinkTypes < ActiveRecord::Migration
  def self.up
    change_table :movie_stream_link_types do |t|
      t.attachment :small_logo
    end
  end

  def self.down
    remove_attachment :movie_stream_link_types, :small_logo
  end
end
