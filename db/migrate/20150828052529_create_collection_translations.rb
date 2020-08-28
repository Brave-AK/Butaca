class CreateCollectionTranslations < ActiveRecord::Migration

  def up
    Collection.create_translation_table!({
      collection_name: :string,
      collection_description_: :text
    }, {
      migrate_data: true
    })
  end

  def down
    Collection.drop_translation_table! migrate_data: true
  end


end
