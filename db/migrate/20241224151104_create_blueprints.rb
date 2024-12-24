class CreateBlueprints < ActiveRecord::Migration[8.0]
  def change
    create_table :blueprints do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
