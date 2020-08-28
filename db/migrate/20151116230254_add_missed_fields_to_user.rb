class AddMissedFieldsToUser < ActiveRecord::Migration
  def up
    add_column :users, :country, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    remove_column :users, :description
  end

  def down
    remove_column :users, :country
    remove_column :users, :first_name
    remove_column :users, :last_name
    add_column :users, :description, :text
  end
end
