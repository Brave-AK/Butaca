class CreateUserLogActivities < ActiveRecord::Migration
  def change
    create_table :user_log_activities do |t|
      t.string :message
      t.belongs_to :notification
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
