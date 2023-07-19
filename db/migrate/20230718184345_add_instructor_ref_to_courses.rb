class AddInstructorRefToCourses < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :instructor, foreign_key: { to_table: :users }
  end
end
