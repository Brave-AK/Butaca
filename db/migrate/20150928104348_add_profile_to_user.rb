class AddProfileToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.text :bio
    end
  end
end
