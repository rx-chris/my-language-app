class CreateCurricula < ActiveRecord::Migration[8.0]
  def change
    create_table :curricula do |t|
      t.string :title, null: false
      t.text :purpose, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :language, null: false, foreign_key: true
      t.text :context
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
