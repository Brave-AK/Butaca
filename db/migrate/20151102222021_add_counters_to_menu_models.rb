class AddCountersToMenuModels < ActiveRecord::Migration
  def up
    add_column :genres, :titles_count, :integer, default: 0, null: false
    add_column :collections, :titles_count, :integer, default: 0, null: false
    add_column :countries, :titles_count, :integer, default: 0, null: false

    [Genre, Collection, Country].each do |model|
      model.reset_column_information
      model.find_each do |instance|
        model.reset_counters instance.id, :titles
      end
    end

  end

  def down
    remove_column :genres, :titles_count
    remove_column :collections, :titles_count
    remove_column :countries, :titles_count
  end
end
