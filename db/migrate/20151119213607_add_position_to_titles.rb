class AddPositionToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :position, :integer
  end
end
