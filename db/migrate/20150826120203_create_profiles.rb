class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.attachment :avatar
    end
    add_foreign_key :profiles, :users
  end
end
