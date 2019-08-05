class CreateSlangs < ActiveRecord::Migration[5.2]
  def change
    create_table :slangs do |t|
      t.string :name

      t.timestamps
    end
  end
end
