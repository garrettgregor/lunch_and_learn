class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string "name"
      t.string "email"
      t.string "password_digest"
      t.string "api_key"
      t.index ["email"], name: "index_users_on_email", unique: true

      t.timestamps
    end
  end
end
