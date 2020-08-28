class CreatePlatformUpdateLogs < ActiveRecord::Migration
  def change
    create_table :platform_update_logs do |t|
      t.belongs_to :title
      t.string :body
      t.timestamps null: false
    end
  end
end
