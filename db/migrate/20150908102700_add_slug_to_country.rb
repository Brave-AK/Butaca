class AddSlugToCountry < ActiveRecord::Migration
  def change
    change_table :countries do |t|
      t.string :slug, uniq: true
    end
  end
end
