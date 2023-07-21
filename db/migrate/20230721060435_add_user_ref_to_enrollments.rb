class AddUserRefToEnrollments < ActiveRecord::Migration[7.0]
  def change
    add_reference :enrollments, :user, foreign_key: true
  end
end
