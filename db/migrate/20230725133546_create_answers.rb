class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :content
      t.references :quiz, null: false, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
