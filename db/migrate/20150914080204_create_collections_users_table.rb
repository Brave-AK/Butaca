class CreateCollectionsUsersTable < ActiveRecord::Migration
  def change
    create_table :collections_users, index: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :collection, index: true
    end
  end
end
