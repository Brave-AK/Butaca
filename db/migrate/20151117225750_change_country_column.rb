class ChangeCountryColumn < ActiveRecord::Migration
  def up
    add_column :users, :country_id, :integer
    remove_column :users, :country
  end

  def down
    add_column :users, :country, :string
    remove_column :users, :country_id
  end
end
