class AddNotShowForMovieStreamLinkType < ActiveRecord::Migration
  def change
    add_column :movie_stream_link_types, :visible, :boolean, default: true
  end
end
