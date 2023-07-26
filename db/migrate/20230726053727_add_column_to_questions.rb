class AddColumnToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :answer1, :string
    add_column :questions, :answer2, :string
    add_column :questions, :answer3, :string
    add_column :questions, :answer4, :string
    add_column :questions, :correct, :integer
  end
end
