class AddSmallLogoForMovieStreamLinkTypes < ActiveRecord::Migration
  def change
    def up
      add_attachment :movie_stream_link_types, :small_logo
    end

    def down
      remove_attachment :movie_stream_link_types, :small_logo
    end
  end
end
