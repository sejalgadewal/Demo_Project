class AddCourseRefToPayments < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :course, foreign_key: true
  end
end
