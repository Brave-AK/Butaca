class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notifier, polymorphic: true, index: true
      t.boolean :email
      t.string :notification_period
      t.belongs_to :user
      t.timestamps null: false
    end

  end
end
