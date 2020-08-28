class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
      t.belongs_to :user
      t.belongs_to :title
      t.timestamps null: false
    end
  end
end
