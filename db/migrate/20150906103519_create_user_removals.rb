class CreateUserRemovals < ActiveRecord::Migration
  def change
    create_table :user_removals do |t|
      t.belongs_to :user
      t.belongs_to :title
      t.timestamps null: false
    end
  end
end
