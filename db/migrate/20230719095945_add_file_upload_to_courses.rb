class AddFileUploadToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :fileupload, :string
  end
end
