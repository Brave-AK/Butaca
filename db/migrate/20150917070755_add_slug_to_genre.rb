class AddSlugToGenre < ActiveRecord::Migration
  def change
    change_table :genres do |t|
      t.string :slug, uniq: true
    end
  end
end
