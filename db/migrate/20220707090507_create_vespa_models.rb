class CreateVespaModels < ActiveRecord::Migration[5.2]
  def change
    create_table :vespa_models do |t|

      t.timestamps
    end
  end
end
