class RenameColumnToUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :courses, :desciption, :description
  end
end
