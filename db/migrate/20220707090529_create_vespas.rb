class CreateVespas < ActiveRecord::Migration[5.2]
  def change
    create_table :vespas do |t|

      t.timestamps
    end
  end
end
