class UpdateStickerUrlToSlangs < ActiveRecord::Migration[5.2]
  def change
    change_column :slangs, :sticker_url, :text
  end
end
