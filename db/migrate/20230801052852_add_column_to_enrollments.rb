class AddColumnToEnrollments < ActiveRecord::Migration[7.0]
  def change
    add_column :enrollments, :status, :integer
    add_column :enrollments, :price, :integer
  end
end
