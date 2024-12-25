class CreateMcqOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :mcq_options do |t|
      t.text :text_content
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
