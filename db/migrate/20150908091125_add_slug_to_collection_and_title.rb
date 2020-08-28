class AddSlugToCollectionAndTitle < ActiveRecord::Migration
  def change
    change_table :titles do |t|
      t.string :slug, uniq: true
    end
    change_table :collections do |t|
      t.string :slug, uniq: true
    end
  end
end
