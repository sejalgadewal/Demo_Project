class CreateCourseFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :course_files do |t|
      t.references :course, null: false, foreign_key: true
      t.string :force
      t.string :name
      t.string :attachment
      t.timestamps
    end
  end
end
