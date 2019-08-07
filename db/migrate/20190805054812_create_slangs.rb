class CreateSlangs < ActiveRecord::Migration[5.2]
  def change
    create_table :slangs do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :sticker_url

      t.timestamps
    end
  end
end
