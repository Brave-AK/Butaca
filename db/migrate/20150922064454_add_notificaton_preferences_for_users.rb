class AddNotificatonPreferencesForUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :notification_preferences, defaulf: "daily"
    end
  end
end
