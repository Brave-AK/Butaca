class ChangeTitles < ActiveRecord::Migration
  def change
    rename_column :titles, :Actors, :actors
    rename_column :titles, :Director, :director
  end
end
