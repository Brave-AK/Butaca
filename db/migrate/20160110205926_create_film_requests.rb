class CreateFilmRequests < ActiveRecord::Migration
  def change
    create_table :film_requests do |t|
      t.text :comment
      t.string :film_name
      t.string :approximate_year
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
