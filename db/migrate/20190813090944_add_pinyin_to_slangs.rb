class AddPinyinToSlangs < ActiveRecord::Migration[5.2]
  def change
    add_column :slangs, :pinyin, :string
  end
end
