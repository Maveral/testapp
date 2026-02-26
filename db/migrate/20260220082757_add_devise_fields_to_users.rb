class AddDeviseFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    change_table :users do |t|
      # Dodaj te linie, jeśli ich nie ma:
      t.string :encrypted_password, null: false, default: ""
      
      # Dodaj też te, jeśli planujesz używać innych modułów Devise:
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
    end

    add_index :users, :reset_password_token, unique: true
  end
end
