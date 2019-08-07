class CreateDefinitions < ActiveRecord::Migration[5.2]
  def change
    create_table :definitions do |t|
      t.text :content
      t.references :slang, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
