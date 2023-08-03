class AddPaymentStatusToEnrollments < ActiveRecord::Migration[7.0]
  def change
    #add_column :enrollments, :payment_status, :string
    add_column :enrollments, :payment_status, :string, default: 'unpaid'

  end
end
