class AddIsNewToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_new, :boolean, default: true
  end
end
