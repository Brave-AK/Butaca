class AddProtectedToMovieStream < ActiveRecord::Migration
  def change
    change_table :movie_streams do |t|
      t.boolean :protect, default: false
    end
  end
end
