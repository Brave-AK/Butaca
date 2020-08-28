class AddStatusForUal < ActiveRecord::Migration
  def change
    change_table :user_log_activities do |t|
      t.boolean :readed, default: false
    end
  end
end
