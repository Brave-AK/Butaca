class ChangeTitleActiveColumn < ActiveRecord::Migration
  class MigrationTitle < ActiveRecord::Base
    self.table_name = 'titles'
  end
  def up
    MigrationTitle.update_all(is_active?: true)
    change_column :titles, :is_active?, :boolean, default: true
  end

  def down
    change_column :titles, :is_active?, :boolean
  end
end
