class AddColumnToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :cardNumber, :integer
    add_column :payments, :expiryDate, :integer
    add_column :payments, :cvv, :integer
  end
end
