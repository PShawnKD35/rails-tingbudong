class AddWechatIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :wechat_id, :string
  end
end
