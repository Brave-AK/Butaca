class AddTransactionTypeToMovieStreamLinkType < ActiveRecord::Migration
  def change
    change_table :movie_stream_link_types do |t|
      t.string :transaction_type
    end
    remove_column :movie_streams, :link_type
  end
end
