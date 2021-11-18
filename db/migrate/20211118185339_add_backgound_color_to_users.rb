class AddBackgoundColorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :background_color, :string
  end
end
