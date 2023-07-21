class AddEnrollmentDateToEnrollments < ActiveRecord::Migration[7.0]
  def change
    add_column :enrollments, :enrollment_date, :date
  end
end
