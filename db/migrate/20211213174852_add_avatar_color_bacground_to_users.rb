class AddAvatarColorBacgroundToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar_color_background, :string
  end
end
