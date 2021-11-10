class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :avatar_url

      t.timestamps null: false
    end
  end
end
