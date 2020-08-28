class CreateMovieStreamLinkTypes < ActiveRecord::Migration
  def change
    create_table :movie_stream_link_types do |t|
      t.string :typel
      t.attachment :logo
      t.timestamps null: false
    end
    change_table :movie_streams do |t|
      t.belongs_to :movie_stream_link_type
    end
  end
end
