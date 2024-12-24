class CreateSelectedCardBlueprints < ActiveRecord::Migration[8.0]
  def change
    create_table :selected_card_blueprints do |t|
      t.references :curriculum, null: false, foreign_key: true
      t.references :blueprint, null: false, foreign_key: true
      t.integer :count, null: false, default: 0

      t.timestamps
    end
  end
end
