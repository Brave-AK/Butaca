class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :author, polymorphic: true, index: true
      t.references :receiver, polymorphic: true, index: true
      t.text :message
      t.timestamps null: false
    end
  end
end
