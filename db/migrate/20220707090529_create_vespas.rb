class CreateVespas < ActiveRecord::Migration[5.1]
  def change
    create_table :vespas do |t|
      t.string :color
      t.decimal :weight
      t.decimal :latitude
      t.decimal :longitude
      t.references :vespa_model, foreign_key: true

      t.timestamps
    end
  end
end
