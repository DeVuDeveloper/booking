class AddAvgRatingToVespa < ActiveRecord::Migration[5.2]
  def change
    add_column :vespas, :average_rating, :decimal, default: 0
  end
end
