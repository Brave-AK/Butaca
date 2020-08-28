class Fixstatus < ActiveRecord::Migration
  def change
    change_table :countries do |t|
      t.boolean :is_active?
    end
    change_table :genres do |t|
      t.boolean :is_active?
    end
    change_table :titles do |t|
      t.boolean :is_active?
    end
    change_table :collections do |t|
      t.boolean :is_featured?
      t.boolean :is_home?
    end
  end
end
