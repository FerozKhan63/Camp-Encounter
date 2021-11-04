class ChangeTableCamps < ActiveRecord::Migration[6.1]
  def change
    remove_column :camps, :status
    add_column :camps, :status, :boolean
  end
end
