class DeleteColumnFromCamps < ActiveRecord::Migration[6.1]
  def change
    remove_column :camps, :locations
  end
end
