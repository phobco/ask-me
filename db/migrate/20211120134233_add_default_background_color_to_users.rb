class AddDefaultBackgroundColorToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :background_color, :string, :default => '#005a55'
  end
end
