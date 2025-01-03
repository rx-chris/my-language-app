class CreateMcqAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :mcq_answers do |t|
      t.references :user_answer
      t.references :model_answer, null: false
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
